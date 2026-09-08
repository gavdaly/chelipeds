#!/usr/bin/env bash
# shellcheck disable=SC2016
set -euo pipefail

usage() {
  echo "Usage: ecosystem-shell.sh [ECOSYSTEM] [ARGS...]"
  echo
  echo "Open an interactive shell backed by the given package ecosystem."
  echo
  echo "  arch    Arch Linux Distrobox using pacman"
  echo "  fedora  Host shell using dnf (the immutable host itself)"
  echo
  echo "Run 'ecosystem-shell.sh list' to list available ecosystems."
}

box_name=""
box_image=""
box_ready=""
box_setup=""

ensure_box() {
  if ! distrobox list --no-color 2>/dev/null | awk '{print $1}' | grep -qx "$box_name"; then
    distrobox create --name "$box_name" --image "$box_image" --yes
  fi

  if ! distrobox enter "$box_name" -- bash -lc "test -f \"\$HOME/$box_ready\"" 2>/dev/null; then
    distrobox enter "$box_name" -- bash -lc "$box_setup"
  fi

  exec distrobox enter "$box_name" "$@"
}

ecosystem_arch() {
  box_name="arch"
  box_image="archlinux:latest"
  box_ready=".chelipeds-arch-ready"
  box_setup='
    set -e
    sudo pacman-key --init && sudo pacman-key --populate archlinux
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm \
      base-devel git curl wget jq \
      neovim ripgrep fd fzf eza zoxide bat tmux zellij just \
      htop btop python python-pip \
      openssh shellcheck
    touch "$HOME/.chelipeds-arch-ready"
  '
  ensure_box "$@"
}

ecosystem_fedora() {
  exec "${SHELL:-/bin/bash}" -l "$@"
}

ecosystem="${1:-fedora}"
if [ $# -gt 0 ]; then shift; fi

case "$ecosystem" in
  arch)
    ecosystem_arch "$@"
    ;;
  fedora)
    ecosystem_fedora "$@"
    ;;
  list)
    echo "Available ecosystems: arch, fedora"
    ;;
  help | -h | --help)
    usage
    ;;
  *)
    echo "Unknown ecosystem: $ecosystem" >&2
    usage
    exit 1
    ;;
esac
