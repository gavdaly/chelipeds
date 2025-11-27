#!/usr/bin/env bash

# This script installs a set of optional applications in userspace using Flatpak.

# Source system tier detection
if [ -f /usr/local/bin/check-system-tier.sh ]; then
    source /usr/local/bin/check-system-tier.sh
else
    echo "Warning: check-system-tier.sh not found. Defaulting to MID tier."
    export CHELIPEDS_SYSTEM_TIER="MID"
fi

echo "Installing userspace applications for tier: $CHELIPEDS_SYSTEM_TIER"


# Development
flatpak install --user -y --noninteractive io.podman_desktop.PodmanDesktop
flatpak install --user -y --noninteractive org.wireshark.Wireshark
flatpak install --user -y --noninteractive io.dbeaver.DBeaverCommunity
if [ "$CHELIPEDS_HAS_VULKAN" = "true" ]; then
    flatpak install --user -y --noninteractive dev.zed.Zed
else
    echo "Skipping Zed (dev.zed.Zed) - No Vulkan support detected."
fi
flatpak install --user -y --noninteractive rest.insomnia.Insomnia
flatpak install --user -y --noninteractive com.visualstudio.code
flatpak install --user -y --noninteractive sh.loft.devpod
flatpak install --user -y --noninteractive md.obsidian.Obsidian
flatpak install --user -y --noninteractive io.typora.Typora

# Media
flatpak install --user -y --noninteractive com.obsproject.Studio
# DaVinci Resolve is not available on Flathub. It must be installed manually.
flatpak install --user -y --noninteractive org.blender.Blender

# Browsers
flatpak install --user -y --noninteractive com.brave.Browser
flatpak install --user -y --noninteractive org.gnome.Epiphany
# Ladybird is not available on Flathub. It must be built from source.
# Servo is not a browser, but an engine. It is not available on Flathub.
flatpak install --user -y --noninteractive org.mozilla.firefox
flatpak install --user -y --noninteractive org.chromium.Chromium
# Flow is not available on Flathub.

# System & Utilities
flatpak install --user -y --noninteractive io.github.kolunmi.Bazaar
flatpak install --user -y --noninteractive io.github.flattool.Warehouse
flatpak install --user -y --noninteractive io.github.zaedus.spider
flatpak install --user -y --noninteractive org.pulseaudio.pavucontrol
flatpak install --user -y --noninteractive org.pipewire.Helvum
flatpak install --user -y --noninteractive me.kozec.syncthingtk
