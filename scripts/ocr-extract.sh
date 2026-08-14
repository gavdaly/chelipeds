#!/usr/bin/env bash
set -euo pipefail
tmpfile="$(mktemp --suffix=.png /tmp/ocr.XXXXXX)"; trap 'rm -f "$tmpfile"' EXIT
grim -g "$(slurp)" "$tmpfile"; tesseract "$tmpfile" - | wl-copy; notify-send "OCR complete" "Text copied to clipboard"
