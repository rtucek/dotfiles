#!/usr/bin/env bash

set -e

nix flake update
nixos-rebuild build --flake .
nvd diff /run/current-system ./result
