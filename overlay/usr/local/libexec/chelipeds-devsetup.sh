#!/usr/bin/env bash
set -euxo pipefail
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.volta/bin:$PATH"

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y || true
~/.cargo/bin/cargo install cargo-binstall || true

# Python (uv)
curl -LsSf https://astral.sh/uv/install.sh | sh || true
~/.local/bin/uv python install latest || true
~/.local/bin/uv python pin latest || true

# Node (Volta)
curl https://get.volta.sh | bash -s -- -y || true
~/.volta/bin/volta install node@latest || true
~/.volta/bin/volta install typescript ts-node eslint prettier npm-check-updates vite vitest jest nodemon http-server || true

# Rust CLIs (fast binaries)
~/.cargo/bin/cargo binstall -y \
  fzf ripgrep fd-find eza zoxide btop \
  lazyjj macchina impala cliphist starship \
  bat git-delta tokei dua-cli dust broot procs hyperfine tealdeer xh gping zellij yazi || true

# Install Userspace Apps (Flatpaks)
echo "Installing userspace applications..."
/usr/local/bin/install-userspace-apps.sh || true

