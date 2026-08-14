#!/usr/bin/env bash
set -euo pipefail
command -v chezmoi >/dev/null || { echo "chezmoi is not installed" >&2; exit 1; }
chezmoi init --apply "$@"
