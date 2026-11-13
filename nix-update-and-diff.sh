#!/usr/bin/env bash

set -Eeuo pipefail

nix flake update
nixos-rebuild build --flake .
nvd diff /run/current-system ./result
