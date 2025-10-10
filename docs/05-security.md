Security is a core feature, not an afterthought.

- **Encryption**: LUKS2 full-disk encryption offered at install.
- **Firewall**: `firewalld` enabled by default. SSH and CUPS (for printing) are the only services exposed to the network.
- **SELinux**: Enforcing mode by default, tuned for workstation/server profiles.
- **Tailscale**: Pre-installed with MagicDNS enabled.
