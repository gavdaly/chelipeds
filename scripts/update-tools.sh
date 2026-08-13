#!/usr/bin/env bash
set -euo pipefail
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.volta/bin:$PATH"
rustup update || true; cargo install-update -a 2>/dev/null || true; volta install node@lts || true; uv self-update 2>/dev/null || true; bootc upgrade
