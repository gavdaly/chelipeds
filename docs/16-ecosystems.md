# Package Ecosystems

Chelipeds keeps the bootc host pure Fedora and exposes other package
ecosystems on top of it, following the same model KDE uses for its own
image-based Linux:

- **Fedora (host)** — `dnf`; the immutable base and the default terminal.
  Use it through `ecosystem-shell.sh fedora`.
- **Arch Linux (Distrobox)** — a rootless `archlinux:latest` container using
  `pacman`.
- **Nix (optional)** — not baked into the image. Users who want it install it
  in user space (single-user, no daemon) with the upstream installer, exactly
  as KDE Linux documents. See [Install Nix on KDE Linux] for the steps; the
  same commands work on Chelipeds.

Project work happens in *development containers* — one per project, defined by
a Dev Container configuration, so build tools and language runtimes load with
the project and never touch the host image.

[Install Nix on KDE Linux]: https://linux.kde.org/docs/nix/

## Switching ecosystems

`ecosystem-shell.sh` opens an interactive shell in the requested ecosystem;
with no argument it defaults to the Fedora host shell:

```bash
ecosystem-shell.sh arch     # Arch Linux Distrobox (pacman)
ecosystem-shell.sh fedora   # host shell with dnf (default)
ecosystem-shell.sh list
```

A graphical picker is bound to `Mod+Shift+Return`; it launches a new Kitty
terminal in the selected ecosystem. Ecosystem containers are created lazily on
first use and the rootless images are shared through Podman, so switching is
cheap after the first download.

## Arch Linux

The Arch ecosystem is a Distrobox named `arch`. On first entry it runs a
pacman keyring bootstrap, a full `pacman -Syu`, and installs an Arch baseline
(build tools and core utilities). Packages are installed with
`pacman -S <name>`. The container shares your home directory and
Wayland/X11 sockets, so GUI apps can run unmodified.

Reconfigure or rebuild the box with plain distrobox commands:

```bash
distrobox rm -f arch
distrobox create --name arch --image archlinux:latest --yes
distrobox enter arch
```

## Nix (optional, user-managed)

Nix is left out of the base image by design; the bootc root is read-only, so a
system-level install would fight the immutable model. Instead, install it in
user space (single-user, no daemon) like KDE Linux:

```bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon
```

Because Chelipeds has a read-only root, create a writable store location and
point `/nix` at it:

```bash
mkdir -p ~/nix/store
sudo ln -s ~/nix /nix
```

Install packages persistently with `nix profile install nixpkgs#<name>`, or run
an ephemeral environment with `nix shell nixpkgs#<name>`. Everything lives in
your home directory; the host image stays untouched.

## Why not install Arch or Nix into the host image?

Layering a second distro's package manager into a bootc image fights the
immutable model: updates become unreliable, rollbacks stop working, and the
distro package managers conflict. Containers (Distrobox) and user-space tools
(Nix) deliver the same packages while keeping the host atomic, reproducible,
and rollback-safe — the tradeoff KDE Linux makes on its own image-based
distribution.
