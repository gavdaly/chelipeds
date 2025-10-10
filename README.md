# Chelipeds — Fedora 43 Hyprland Dev ISO

![crab typing](cheliped_cover.avif)

Custom rpm-ostree image with Niri + dev tooling.

## What you get

- Niri, Waybar, Wofi, MakO notifications
- Dev stack: gcc/clang/cmake/ninja/neovim/git
- Containers: podman/buildah/skopeo/toolbox/distrobox
- Terminals: Kitty
- Flatpak + Flathub
- Flatpaks preinstalled: Chromium, Zed

## Paths

- CI workflow: `.github/workflows/build-iso.yml`
- Local build scripts: `scripts/`

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

Requires Linux with podman + CoreOS Assembler tools.

```bash
./scripts/build-local.sh
```

## Distro Layout

### User Projects & Workflows

- Codebases: Rust, Node.js, Python, C/C++
- AI workflows: Claude, Gemini, Codex CLIs

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

- 03:00 daily: update-tools.sh (Rust, Node, Python, CLIs)
- 03:15 daily: rpm-ostree upgrade (immutable OS updates)

### Networking, Access, and Security │

- SELinux (enforcing)
- firewalld enabled
- SSH + Mosh remote access
- Tailscale VPN mesh
