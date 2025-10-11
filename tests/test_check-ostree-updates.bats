#!/usr/bin/env bats

@test "check-ostree-updates.sh runs without errors" {
  run ../overlay/usr/local/bin/check-ostree-updates.sh
  [ "$status" -eq 0 ]
}
