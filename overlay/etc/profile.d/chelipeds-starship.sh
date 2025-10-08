if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"; eval "$(starship init zsh)"
fi
