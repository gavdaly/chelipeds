#!/usr/bin/env bash
# Auto-detect system performance and launch Niri with the right profile.
# - Sets NIRI_PROFILE=PERFORMANCE if:
#     - > 6 CPU threads, and
#     - GPU is AMD, Intel Arc, or NVIDIA (non-llvmpipe)
# - Otherwise, uses NIRI_PROFILE=STANDARD.

set -euo pipefail

### --- CPU detection ---
threads=$(nproc 2>/dev/null || grep -c ^processor /proc/cpuinfo)
echo "Detected $threads CPU threads."

### --- GPU detection ---
gpu_info=$(lspci | grep -E "VGA|3D" || true)
renderer=$(glxinfo 2>/dev/null | grep "renderer string" || echo "unknown")

### --- Decide performance profile ---
profile="STANDARD"

# Detect modern GPU vendors (rough heuristic)
if [[ $threads -gt 6 ]]; then
    if echo "$gpu_info" | grep -qiE "NVIDIA|AMD|Radeon|Arc|Intel"; then
        if ! echo "$renderer" | grep -qi "llvmpipe"; then
            profile="PERFORMANCE"
        fi
    fi
fi

echo "GPU info: $gpu_info"
echo "Renderer: $renderer"
echo "Selected profile: $profile"

export NIRI_PROFILE="$profile"

### --- Optional environment tuning ---
if [[ "$profile" == "PERFORMANCE" ]]; then
    export NIRI_DISABLE_VSYNC=1
    export NIRI_NO_HARDWARE_CURSORS=0
else
    export NIRI_DISABLE_VSYNC=0
fi
