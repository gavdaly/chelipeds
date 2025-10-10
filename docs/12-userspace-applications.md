# Userspace Applications

Chelipeds provides a script to install a curated set of optional applications in your userspace. This allows you to easily add applications without affecting the base system.

## Installation

To install the optional applications, run the following command in your terminal:

```bash
install-userspace-apps.sh
```

This script will install a variety of applications using Flatpak, including development tools, browsers, and system utilities. The applications will be installed in your home directory, and will not require root privileges.

## Included Applications

The script will install the following applications:

*   **Development**: Podman Desktop, Wireshark, DBeaver, Zed, Insomnia, Visual Studio Code, DevPod, Obsidian, Typora
*   **Media**: OBS Studio, Blender
*   **Browsers**: Brave, Epiphany, Firefox, Chromium
*   **System & Utilities**: Bazaar, Warehouse, Spider, PulseAudio Volume Control, Helvum, Syncthing-GTK

## Unavailable Applications

Some applications that were previously considered for inclusion are not available on Flathub and must be installed manually:

*   **DaVinci Resolve**: Can be downloaded from the Blackmagic Design website.
*   **Ladybird**: Must be built from source.
*   **Servo**: A browser engine, not a standalone browser.
*   **Flow**: Not currently available.
