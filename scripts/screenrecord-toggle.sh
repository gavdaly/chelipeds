#!/usr/bin/env bash
set -euo pipefail
pidfile=/tmp/wf-recorder.pid
if [[ -f "$pidfile" ]] && kill -0 "$(<"$pidfile")" 2>/dev/null; then kill "$(<"$pidfile")"; rm -f "$pidfile"; notify-send "Recording saved"; else mkdir -p "$HOME/Videos"; wf-recorder -g "$(slurp)" -f "$HOME/Videos/record-$(date +%Y%m%d-%H%M%S).mp4" & echo $! > "$pidfile"; notify-send "Recording started"; fi
