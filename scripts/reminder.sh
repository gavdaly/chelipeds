#!/usr/bin/env bash
set -euo pipefail
[[ $# -ge 2 ]] || { echo "Usage: reminder.sh MINUTES MESSAGE" >&2; exit 2; }
minutes=$1; shift; (sleep "${minutes}m" && notify-send "⏰ Reminder" "$*" --urgency=critical) & echo "Reminder set for $minutes minutes: $*"
