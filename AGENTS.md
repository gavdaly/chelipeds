# Repository Guidelines

## Project Structure & Module Organization
The root `Containerfile` defines the Fedora bootc image; treat it as the single source for base packages and image metadata. The `overlay/` tree mirrors the target filesystem—`overlay/etc/profile.d/` sets session defaults, `overlay/etc/systemd/system/` carries service units and timers, and `overlay/usr/local/{bin,libexec}/` holds helper scripts. Place new assets inside the matching overlay path so they land in the final image. Markdown references and contributor docs live in `docs/`, which uses a numbered prefix to keep the handbook ordered.

## Build, Test, and Development Commands
- `podman build -t chelipeds:dev .` — validates the `Containerfile` syntax and ensures the overlay copies cleanly.
- `podman run --rm --privileged -v "$PWD:/work:z" -w /work quay.io/fedora/bootc-image-builder:latest --type iso --filename chelipeds.iso` — mirrors the CI ISO build locally; expect artifacts in `./output/`.
- `podman run --rm chelipeds:dev bootc status` — quick smoke test that staged services and binaries resolve inside the built image.

## Coding Style & Naming Conventions
Shell scripts must start with `#!/usr/bin/env bash`, enable `set -euo pipefail`, and use two-space indentation for continuations. Prefer uppercase snake-case for environment variables, lowercase hyphen-separated names for files in `overlay/usr/local/bin/`, and keep functions lowercase with underscores. Run `shellcheck` on any new script and keep commands POSIX-friendly unless Fedora tooling requires otherwise.

## Testing Guidelines
There is no dedicated automated test suite; treat the build commands above as required pre-flight checks. Script changes should pass `bash -n` and `shellcheck` locally, and service unit edits should be validated with `systemd-analyze verify overlay/etc/systemd/system/<unit>.service`. When adjusting timers or update flows, boot the locally built ISO in a VM and confirm the systemd units reach `active` without manual intervention.

## Commit & Pull Request Guidelines
Follow the conventional `type: short imperative description` format observed in history (`fix:`, `feat:`, `docs:`, `chore:`). Keep commits focused—one functional change per commit—and update affected docs alongside code. Pull requests should include a short summary, links to tracked issues when relevant, test output for the commands above, and screenshots or logs when touching user-visible behavior.

## Security & Configuration Tips
Sensitive credentials never belong in the repo; rely on secret stores or CI-provided environment variables. For new services under `overlay/etc/systemd/system/`, default to disabled and explicitly document how to opt in. Review firewall, SSH, and update scripts for least-privilege defaults, and avoid embedding tokens in helper scripts or profile fragments.
