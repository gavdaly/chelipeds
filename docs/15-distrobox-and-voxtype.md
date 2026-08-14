# Distrobox and Voxtype

Chelipeds keeps terminal and development workloads in the `dev` Distrobox. Kitty and the Niri terminal bindings enter it automatically. The immutable host retains only desktop, Wayland, systemd, networking, and bootc integration packages.

The first terminal launch creates an Ubuntu 24.04 container and installs the baseline tools. `mise` then manages Node.js, Python, Rust, and project CLIs inside the container. This keeps toolchains mutable without changing the bootc image.

Voxtype runs locally through its Parakeet ONNX backend. The default configuration selects `parakeet-tdt-0.6b-v2`, an English TDT model. After the first login, run:

```bash
setup-voxtype-parakeet.sh
```

This enables the ONNX backend, downloads the model, and opens Voxtype’s configuration UI. Use `F9` for push-to-talk or `Mod+Ctrl+X` for toggle mode. Parakeet is English-focused; switch the config back to Whisper for multilingual dictation.
