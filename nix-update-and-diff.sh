#!/usr/bin/env bash

set -Eeuo pipefail

nix flake update
nix-fast-build \
	--flake .#nixosConfigurations \
	--select 'configs: builtins.mapAttrs (_: cfg: cfg.config.system.build.toplevel) configs' \
	--skip-cached

# Still rebuild the "classical" way, so we can diff what has changed
nixos-rebuild build --flake .
nvd diff /run/current-system ./result
