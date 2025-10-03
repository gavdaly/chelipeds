#!/usr/bin/env bash
set -euo pipefail
FILE="${1:?usage: $0 path/to/file}"
sha256sum "$FILE" | tee "${FILE}.sha256"
echo "SHA256 written to ${FILE}.sha256"
