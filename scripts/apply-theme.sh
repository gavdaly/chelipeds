#!/usr/bin/env bash
set -euo pipefail
theme=${1:-chelipeds}; source_dir="/etc/skel/.config/chelipeds/themes/$theme"; [[ -d "$source_dir" ]] || { echo "Unknown theme: $theme" >&2; exit 1; }
mkdir -p "$HOME/.config/chelipeds/themes/$theme" "$HOME/.config/waybar" "$HOME/.config/mako" "$HOME/.config/btop"
cp -a "$source_dir/." "$HOME/.config/chelipeds/themes/$theme/"; cp "$source_dir/waybar.css" "$HOME/.config/waybar/style.css"; cp "$source_dir/mako.ini" "$HOME/.config/mako/config"; cp "$source_dir/btop.theme" "$HOME/.config/btop/chelipeds.theme"
notify-send "Theme applied" "$theme" 2>/dev/null || true
