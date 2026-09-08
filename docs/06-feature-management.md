Our spins are modular. Features can be toggled at build/install time.

## Post-install storage

### Bcachefs data directory

Bcachefs is intentionally not used for the bootc root filesystem. After installation, an administrator may opt in to a separate Bcachefs data volume mounted at `/data`.

This is a post-install configuration rather than a `bootc-config.json` customization: the target device must be selected on the installed system, and formatting must be an explicit action. The setup must never auto-select or format an unused disk.

Examples:

- **Development**: Podman Desktop, Wireshark, DBeaver, Zed, Insomnia.
- **Media (optional)**: OBS Studio, DaVinci Resolve, Blender.
- **Browsers**: Brave, Epiphany, Ladybird, Servo (experimental).
