# Show macchina in new interactive terminals
if [ -n "$PS1" ] && [ -t 1 ] && command -v macchina >/dev/null 2>&1; then
  macchina || true
fi
