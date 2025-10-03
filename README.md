# Chelipeds — Fedora 42 Hyprland Dev ISO

Custom rpm-ostree image with Hyprland + dev tooling. Builds a Live ISO and publishes it to a Cloudflare R2 bucket via GitHub Actions.

## What you get

- Hyprland, Waybar, Wofi, MakO notifications
- Dev stack: gcc/clang/cmake/ninja/neovim/git
- Containers: podman/buildah/skopeo/toolbox/distrobox
- Terminals: Ghostty + Kitty
- Flatpak + Flathub + GNOME Software (GUI store)
- Flatpaks preinstalled: Chromium, Zed, VS Code
- Flatpak overrides (Wayland, GPU, $HOME)
- CLI symlinks: `zed`, `code`

## Paths

- Config (Butane JSON): `configs/chelipeds-hyperland-dev.json`
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
