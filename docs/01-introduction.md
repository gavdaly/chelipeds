# Introduction to Chelipeds

Chelipeds is an opinionated, reproducible Linux environment designed for developers who value productivity, security, and a streamlined workflow. It provides a pre-configured, container-based system that eliminates the need to manually piece together a development environment from scratch.

This "Niri Dev" image is specifically tailored for developers and includes:

*   A modern, tiling-based desktop environment featuring the Niri window manager.
*   A comprehensive development toolchain with pre-installed languages like Rust, Python, and Node.js.
*   A curated set of command-line tools to enhance productivity.
*   A secure-by-default configuration with a firewall, SELinux, and other security features.
*   A container-centric workflow with Podman, Toolbox, and Distrobox.

Chelipeds is built on a foundation of Fedora and leverages `bootc` for atomic updates and system rollbacks, ensuring a stable and reliable system.

## Developer Environment

The "Niri Dev" image of Chelipeds comes with a comprehensive development environment pre-installed. This environment is designed to be ready to use out of the box, with a focus on modern languages and tools.

### Languages

*   **Rust**: The Rust toolchain is installed via `rustup`, and includes `cargo` and `rustc`.
*   **Python**: A recent version of Python is installed and managed using `uv`.
*   **Node.js**: The latest LTS version of Node.js is installed and managed using `volta`.

### Command-Line Tools

A wide range of command-line tools are included to enhance productivity:

*   **File Management**: `fzf`, `ripgrep`, `fd-find`, `eza`, `zoxide`, `broot`, `yazi`
*   **System Monitoring**: `btop`, `procs`, `gping`
*   **Git**: `lazyjj`, `git-delta`
*   **Development**: `bat`, `tokei`, `dua-cli`, `dust`, `hyperfine`, `tealdeer`, `xh`
*   **Other**: `macchina`, `impala`, `cliphist`, `starship`, `zellij`

### Customization

The development environment is set up by the `chelipeds-devsetup.sh` script, which is run automatically for new users. You can customize the installed tools by modifying this script in the `overlay/usr/local/libexec/` directory.

## Default Applications

The Chelipeds "Niri Dev" image includes a minimal set of desktop applications to provide a clean and focused environment. You can install additional applications via Flatpak or by adding them to the `Containerfile`.

### Included Applications

*   **File Manager**: Nautilus
*   **Terminal Emulator**: Kitty
*   **Text Editor**: Neovim (command-line)

### Web Browser

No web browser is installed by default. This allows you to choose the browser that best fits your workflow. You can install a browser via Flatpak, for example:

```bash
flatpak install flathub com.google.Chrome
```

Or, you can add a browser package to the `Containerfile`.