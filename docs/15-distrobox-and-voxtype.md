# Distrobox and Voxtype

Chelipeds runs terminals on the immutable host. Project work happens in
per-project dev containers, and optional ecosystems like Arch are offered as
Distrobox environments. The immutable host retains only desktop, Wayland,
systemd, networking, and bootc integration packages.

Development toolchains live in user space (rustup, uv, Volta) so they stay
mutable without changing the bootc image.

Voxtype runs locally through its Parakeet ONNX backend. The default configuration selects `parakeet-tdt-0.6b-v2`, an English TDT model. After the first login, run:

```bash
setup-voxtype-parakeet.sh
```

This enables the ONNX backend, downloads the model, and opens Voxtype’s configuration UI. Use `F9` for push-to-talk or `Mod+Ctrl+X` for toggle mode. Parakeet is English-focused; switch the config back to Whisper for multilingual dictation.
