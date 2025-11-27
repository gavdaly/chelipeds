# zoxide smarter cd
if command -v zoxide >/dev/null 2>&1; then
  if [ -n "${BASH_VERSION:-}" ]; then
    eval "$(zoxide init bash)"
  elif [ -n "${ZSH_VERSION:-}" ]; then
    eval "$(zoxide init zsh)"
  fi
fi

# fzf legacy binds if present (safe no-op otherwise) - bash only
if [ -n "${BASH_VERSION:-}" ]; then
  for f in /usr/share/fzf/*.bash; do [ -r "$f" ] && . "$f"; done 2>/dev/null || true
fi
