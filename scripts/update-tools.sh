#!/usr/bin/env bash
# shellcheck disable=SC2016
set -euo pipefail
/usr/local/libexec/update-tools.sh
bootc upgrade
