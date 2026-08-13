#!/usr/bin/env bash
set -euo pipefail

if bootc status --json 2>/dev/null | jq -e '.status.staged != null' >/dev/null 2>&1; then
  notify-send --urgency=normal "Chelipeds update ready" "A bootc update is staged. Reboot when convenient."
fi
