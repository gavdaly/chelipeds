#!/usr/bin/env bash
# shellcheck disable=SC2016
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
    curl https://mise.run | sh
    export PATH="$HOME/.local/bin:$PATH"
    mise use --global node@lts python@3.13 rust@stable
    mise use --global npm:typescript npm:eslint npm:prettier npm:vite npm:vitest
    mise use --global cargo:cargo-binstall cargo:cargo-edit cargo:cargo-watch cargo:cargo-nextest
    touch "$HOME/.chelipeds-dev-ready"
  '
fi
exec distrobox enter "$box_name" "$@"
