#!/usr/bin/env bash
set -euo pipefail
flatpak --system remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
for app in org.chromium.Chromium dev.zed.Zed md.obsidian.Obsidian com.typora.Typora org.gustavoperedo.FontDownloader; do flatpak install -y flathub "$app"; done
