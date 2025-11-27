#!/usr/bin/env bash
set -euo pipefail

# Function to detect system tier
detect_system_tier() {
    # 1. RAM (in MB)
    local total_mem_mb
    total_mem_mb=$(free -m | awk '/^Mem:/{print $2}')

    # 2. CPU Cores
    local cpu_cores
    cpu_cores=$(nproc)

    # 3. GPU Detection
    # Check for NVIDIA or AMD GPUs using lspci if available, or /sys/class/drm
    local has_dedicated_gpu=false
    if command -v lspci &> /dev/null; then
        if lspci | grep -E -i "vga|3d|display" | grep -E -i "nvidia|amd|ati" &> /dev/null; then
            has_dedicated_gpu=true
        fi
    fi

    # 4. Disk Space (Root partition free space in GB)
    local free_space_gb
    free_space_gb=$(df -BG / | awk 'NR==2 {print $4}' | sed 's/G//')

    # 5. Vulkan Support (for Zed)
    # Check for render nodes in /dev/dri
    local has_vulkan=false
    if [ -d "/dev/dri" ] && ls /dev/dri/render* &> /dev/null; then
        has_vulkan=true
    fi
    # Ideally we would check for Vulkan 1.3 specifically, but without vulkan-tools (vulkaninfo),
    # checking for a render node is a reasonable proxy for "has 3D acceleration".

    # Logic for Tier
    # Low: < 8GB RAM OR < 4 Cores
    # Mid: 8GB-32GB RAM AND 4-12 Cores
    # High: > 32GB RAM OR > 12 Cores OR Dedicated GPU

    local tier="MID" # Default

    if [ "$total_mem_mb" -lt 7800 ] || [ "$cpu_cores" -lt 4 ]; then
        tier="LOW"
    elif [ "$total_mem_mb" -gt 32000 ] || [ "$cpu_cores" -gt 12 ] || [ "$has_dedicated_gpu" = true ]; then
        tier="HIGH"
    fi

    # Export variables
    export CHELIPEDS_SYSTEM_TIER="$tier"
    export CHELIPEDS_FREE_SPACE_GB="$free_space_gb"
    export CHELIPEDS_HAS_GPU="$has_dedicated_gpu"
    export CHELIPEDS_HAS_VULKAN="$has_vulkan"

    echo "System Detection:"
    echo "  RAM: ${total_mem_mb} MB"
    echo "  Cores: ${cpu_cores}"
    echo "  GPU: ${has_dedicated_gpu}"
    echo "  Vulkan (Zed Ready): ${has_vulkan}"
    echo "  Free Space: ${free_space_gb} GB"
    echo "  Tier: ${tier}"
}


detect_system_tier
