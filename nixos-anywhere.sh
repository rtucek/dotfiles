#!/usr/bin/env bash

temp=$(mktemp -d)

cleanup() {
  rm -rf "$temp"
}
trap cleanup EXIT

install -d -m700 "$temp/secrets"
sops decrypt \
	--extract '["age_key"]' \
	--output $temp/secrets/keys.txt \
	./secrets/users/rtucek.yaml
chmod 600 "$temp/secrets/keys.txt"

SSHPASS=nixos nix run github:nix-community/nixos-anywhere -- \
	--env-password \
	--extra-files "$temp" \
	--disk-encryption-keys /tmp/disk.key <(sops decrypt --extract '["luks_key"]' secrets/hosts/qemu-nixos-btw.yaml) \
	--generate-hardware-config nixos-generate-config ./hosts/qemu-nixos-btw/hardware-configuration.nix \
	--flake .#qemu-nixos-btw \
	--target-host nixos@qemu
