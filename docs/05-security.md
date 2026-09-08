Security is a core feature, not an afterthought.

- **Encryption**: LUKS2 full-disk encryption offered at install.
- **Firewall**: `firewalld` enabled by default. SSH (and Mosh for remote sessions) is available via the installed OpenSSH server; everything else is blocked unless explicitly opened.
- **SELinux**: Enforcing mode by default, tuned for workstation/server profiles.
