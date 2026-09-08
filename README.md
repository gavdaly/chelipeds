# Chelipeds — Fedora 44 bootc Dev Image

![crab typing](cheliped_cover.avif)

Custom Fedora bootc image with Niri, developer tooling, and a warm dark `chelipeds` theme.

## What you get

- Niri, Waybar, Wofi, Mako notifications, screenshots, recording, OCR, and clipboard history
- Dev tooling runs on the host: rustup/cargo, uv, Volta/Node, plus a curated set of CLIs
- Multiple ecosystems (`ecosystem-shell.sh`): `arch` Distrobox (pacman) and the `fedora` host shell; project work happens in per-project dev containers
- Containers: podman/buildah/skopeo/toolbox/distrobox
- Terminals: Kitty and Zellij on the host by default; `Mod+Shift+Return` picks an ecosystem
- Flatpak + Flathub
- Flatpaks installed on first boot: Chromium, Zed, Obsidian, Typora, and Font Downloader
- Dictation with Voxtype using Parakeet TDT v2, plus lazy-installed AI CLIs: Claude, Codex, Gemini, Grok Build, Antigravity, and Kimi Code

Terminal sessions run on the immutable host; development toolchains are installed per-user and never modify the bootc image. Graphical, Wayland, and systemd integration stay host-level, while project-specific environments live in dev containers.

Node.js is managed with `volta`, Python with `uv`, and Rust with `rustup`, all in user space. Voxtype is configured for local Parakeet TDT v2; run `setup-voxtype-parakeet.sh` once after installation to download its model.

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
# The image expects the Parakeet-enabled Voxtype binary in the build context.
cargo install --root "$PWD/voxtype-root" --git https://github.com/peteonrails/voxtype.git --tag v0.7.5 voxtype --features parakeet
cp voxtype-root/bin/voxtype voxtype-bin
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
- Arch Linux Distrobox (`ecosystem-shell.sh arch`) on the immutable host. Nix stays user-managed. Project work happens in per-project dev containers. See `docs/16-ecosystems.md`.

### Automation & Maintenance (systemd timers)

- 03:00 daily: `update-tools.sh` (Rust, Node, Python, and user-space tools)
- bootc update checks run periodically and stage an image update when available.
- On graphical login, Chelipeds notifies the user when an update has been staged. It never reboots automatically.

To apply a staged image update, run `sudo bootc upgrade` and reboot when convenient.

### Networking, Access, and Security │

- SELinux (enforcing)
- firewalld enabled
- SSH + Mosh remote access
