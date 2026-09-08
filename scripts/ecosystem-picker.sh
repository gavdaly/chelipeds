#!/usr/bin/env bash
set -euo pipefail

# Pick a package ecosystem and open a new Kitty terminal inside it.
selected=$(printf 'arch\nfedora\n' | wofi --dmenu --prompt 'Ecosystem:')
[ -z "$selected" ] && exit 0

exec kitty -e /usr/local/bin/ecosystem-shell.sh "$selected"
