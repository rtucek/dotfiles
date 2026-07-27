#!/usr/bin/env bash

set -e

temp=$(mktemp -d)

cleanup() {
  rm -rf "$temp"
}
trap cleanup EXIT

# Setup machine key
install -d -m700 "$temp/secrets"
sops decrypt \
	--extract '["host_key"]' \
	--output "$temp/secrets/keys.txt" \
	secrets/hosts/qemu-nixos-btw.yaml
chmod 600 "$temp/secrets/keys.txt"

# Setup user key
install -d -m700 "$temp/home/rtucek/.config/sops/age"
sops decrypt \
	--extract '["age_key"]' \
	--output "$temp/home/rtucek/.config/sops/age/keys.txt" \
	secrets/users/rtucek.yaml
chmod 600 "$temp/home/rtucek/.config/sops/age/keys.txt"

SSHPASS=nixos nix run github:nix-community/nixos-anywhere -- \
	--env-password \
	--extra-files "$temp" \
	--chown "/home/rtucek" "1000:100" \
	--disk-encryption-keys \
		/tmp/disk.key \
		<( \
			sops decrypt \
				--extract '["luks_key"]' \
				secrets/hosts/qemu-nixos-btw.yaml \
		) \
	--generate-hardware-config nixos-generate-config ./hosts/qemu-nixos-btw/hardware-configuration.nix \
	--flake .#qemu-nixos-btw \
	--target-host nixos@qemu
