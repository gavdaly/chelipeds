# zoxide smarter cd
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"; eval "$(zoxide init zsh)"
fi
# fzf legacy binds if present (safe no-op otherwise)
for f in /usr/share/fzf/*.bash; do [ -r "$f" ] && . "$f"; done 2>/dev/null || true
