#!/usr/bin/env bash
set -euo pipefail
distrobox enter dev -- bash -lc 'export PATH="$HOME/.local/bin:$PATH"; mise self-update --yes || true; mise upgrade || true'
bootc upgrade
