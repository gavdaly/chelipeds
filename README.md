# Chelipeds — Fedora 44 bootc Dev Image

![crab typing](cheliped_cover.avif)

Custom Fedora bootc image with Niri, developer tooling, and a warm dark `chelipeds` theme.

## What you get

- Niri, Waybar, Wofi, Mako notifications, screenshots, recording, OCR, and clipboard history
- Dev stack runs inside the `dev` Distrobox: gcc/clang/cmake/ninja/neovim/git and terminal tooling
- Containers: podman/buildah/skopeo/toolbox/distrobox
- Terminals: Ghostty (primary), Kitty (fallback), and Zellij; all automatically enter the `dev` Distrobox
- Flatpak + Flathub
- Flatpaks installed on first boot: Chromium, Zed, Obsidian, Typora, and Font Downloader
- Dictation with Voxtype using Parakeet TDT v2, plus lazy-installed AI CLIs: Claude, Codex, Gemini, Grok Build, Antigravity, and Kimi Code

Terminal sessions are intentionally isolated from the immutable host. The first terminal launch creates an Ubuntu 24.04 `dev` Distrobox and installs the terminal/development baseline there. Host-level commands are limited to graphical, Wayland, systemd, and bootc integration tools.

Node.js is managed with `mise` inside Distrobox. It handles Node, Python, Rust, and project-local CLI versions in one toolchain, replacing the earlier host-level Volta setup. Voxtype is configured for local Parakeet TDT v2; run `setup-voxtype-parakeet.sh` once after installation to download its model.

## Paths

- CI workflow: `.github/workflows/build-iso.yml`

## Cloud build (GitHub Actions → R2)

1. Add repo secrets:
   - `CF_R2_ACCOUNT_ID`
   - `CF_R2_ACCESS_KEY_ID`
   - `CF_R2_SECRET_ACCESS_KEY`
   - `CF_R2_BUCKET` (e.g. `chelipeds`)
   - `CF_R2_PUBLIC_HOST` (R2 custom domain, e.g. `downloads.example.com`)
2. Push to `main` (or run the workflow manually).
3. Workflow builds ISO, uploads to R2, and opens a GitHub Release with links.

Download URLs (example):
https://<CF_R2_PUBLIC_HOST>/iso/chelipeds-hyperland-dev-.iso
https://<CF_R2_PUBLIC_HOST>/iso/chelipeds-hyperland-dev-.sha256

## Local build (optional)

Requires Linux with Podman. The image build uses Fedora bootc; ISO generation uses `bootc-image-builder`.

```bash
podman build -t chelipeds:dev .
podman run --rm chelipeds:dev bootc status
```

## Distro Layout

### User Projects & Workflows

- Codebases: Rust, Node.js, Python, C/C++
- AI workflows: Claude, Gemini, Codex, Grok Build, Antigravity, and Kimi Code CLIs

### Toolchains & CLIs

- 🦀 Rust (rustup, cargo, cargo-binstall)
- 🟢 Node.js (Volta) → TS, ESLint, Prettier, Vite, Vitest…
- 🐍 Python (uv, pinned latest)
- ⚙️ C/C++ (gcc, clang, cmake, ninja, gdb from Fedora)
- 🤖 AI CLIs (Volta): Claude, Gemini, Codex

### Dev Utilities & TUIs

- Core: fzf, ripgrep, fd, bat, yq, eza
- Git/Versioning: gitui, lazygit, jj, lazyjj, delta
- File managers: yazi, nnn, ranger, broot, dua-cli, dust
- System monitors: bottom, btop, bandwhich, kmon
- Productivity: just, cargo-edit, cargo-watch, nextest
- Helpers: tokei, tealdeer, xh, gping, eva, pastel, hyperfine
- Shell/UX: starship, zellij, lazydocker

### Container & Virtualization Layer │

- Podman, podman-compose, podman-tui, buildah, skopeo, crun
- Toolbox, Distrobox

### Automation & Maintenance (systemd timers)

- 03:00 daily: `update-tools.sh` (Rust, Node, Python, and user-space tools)
- bootc update checks run periodically and stage an image update when available.
- On graphical login, Chelipeds notifies the user when an update has been staged. It never reboots automatically.

To apply a staged image update, run `sudo bootc upgrade` and reboot when convenient.

### Networking, Access, and Security │

- SELinux (enforcing)
- firewalld enabled
- SSH + Mosh remote access
- Tailscale VPN mesh
