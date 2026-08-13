#!/usr/bin/env bash
set -euo pipefail
voxtype setup onnx --enable
voxtype setup model --engine parakeet --model parakeet-tdt-0.6b-v2
voxtype configure
