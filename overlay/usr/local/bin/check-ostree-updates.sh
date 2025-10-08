#!/usr/bin/env bash
# Chelipeds: bootc-based update check (stages updates, no reboot)
set -euo pipefail

STATE_DIR=/var/lib/chelipeds
FLAG="$STATE_DIR/updates-available"
STATUS_JSON="$STATE_DIR/bootc-status.json"
LOG_TXT="$STATE_DIR/upgrade-check.txt"

mkdir -p "$STATE_DIR"
rm -f "$FLAG" || true

bootc upgrade || true

if bootc status --json >"$STATUS_JSON" 2>/dev/null; then
  date -Is > "$LOG_TXT"

  if jq -e '.status.staged != null' < "$STATUS_JSON" >/dev/null 2>&1; then
    touch "$FLAG"
  fi
else
  bootc status > "$LOG_TXT" 2>&1 || true
fi
