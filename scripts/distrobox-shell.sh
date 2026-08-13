#!/usr/bin/env bash
set -euo pipefail
box_name=dev
if ! distrobox list --no-color 2>/dev/null | awk '{print $1}' | grep -qx "$box_name"; then
  distrobox create --name "$box_name" --image ubuntu:24.04 --yes
fi

# Keep terminal and development tooling inside Distrobox. This runs once per box.
if ! distrobox enter "$box_name" -- bash -lc 'test -f "$HOME/.chelipeds-dev-ready"' 2>/dev/null; then
  distrobox enter "$box_name" -- bash -lc '
    set -e
    sudo apt-get update
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
      build-essential clang cmake ninja-build gdb git curl wget jq \
      neovim ripgrep fd-find bat fzf eza tmux zellij just htop btop \
      python3 python3-pip python3-venv shellcheck podman-compose \
      ca-certificates pkg-config
    touch "$HOME/.chelipeds-dev-ready"
  '
fi
exec distrobox enter "$box_name" "$@"
