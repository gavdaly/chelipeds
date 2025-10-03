#!/usr/bin/env bash
set -euo pipefail

ISO_NAME="${ISO_NAME:-chelipeds-hyperland-dev.iso}"
IGN_NAME="${IGN_NAME:-chelipeds-hyperland-dev.ign}"
BUTANE_JSON="${BUTANE_JSON:-configs/chelipeds-hyperland-dev.json}"
COSA_IMAGE="${COSA_IMAGE:-quay.io/coreos-assembler/coreos-assembler:latest}"

mkdir -p artifacts build cosa

echo "[1/4] Generate ignition from ${BUTANE_JSON}"
butane -s < "${BUTANE_JSON}" > "build/${IGN_NAME}"

echo "[2/4] Pull cosa image"
podman pull "${COSA_IMAGE}"

echo "[3/4] Initialize cosa workspace"
pushd cosa >/dev/null
podman run --rm -ti --privileged -v "$PWD":/srv/ "${COSA_IMAGE}" bash -lc "cosa init https://github.com/coreos/fedora-coreos-config"
cp "../build/${IGN_NAME}" "./${IGN_NAME}"

echo "[4/4] Build ISO"
podman run --rm -ti --privileged -v "$PWD":/srv/ "${COSA_IMAGE}" bash -lc "
  set -euo pipefail
  cosa fetch
  cosa build
  cosa buildextend-live --ignition ${IGN_NAME}
"
ISO_PATH=$(ls -1 builds/latest/x86_64/*-live.x86_64.iso | head -n1)
popd >/dev/null

cp "${ISO_PATH}" "artifacts/${ISO_NAME}"
echo "ISO ready: artifacts/${ISO_NAME}"

./scripts/checksums.sh "artifacts/${ISO_NAME}"
