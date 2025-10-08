#!/usr/bin/env bash
set -euxo pipefail
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.volta/bin:$PATH"
rustup update || true
cargo install-update -a || true
uv python install latest && uv python pin latest || true
volta install node@latest || true
volta install npm-check-updates eslint prettier typescript ts-node vite vitest jest nodemon http-server || true
cargo binstall -y --force \
  fzf ripgrep fd-find eza zoxide btop \
  lazyjj macchina impala cliphist starship \
  bat git-delta tokei dua-cli dust broot procs hyperfine tealdeer xh gping zellij yazi || true
