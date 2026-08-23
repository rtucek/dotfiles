#!/usr/bin/env bash

set -Eeuo pipefail

# Delete tmp dir
cleanup() {
	[[ -n "${TEMP_DIR:-}" ]] && rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

# Check dependencies
require() {
	command -v "$1" > /dev/null 2>&1 || {
		echo "Missing dependency $1"
		exit 1
	}
}
for CMD in sops nix mktemp install realpath; do
	require "$CMD"
done

### Minimalistic validation ###

# Check passwords are matching
# $1: original password
# $2: password repeated
check_pw_match() {
	LUKS_PASSWORD="$1"
	LUKS_PASSWORD_REPEAT="$2"
	if [[ "$LUKS_PASSWORD" != "$LUKS_PASSWORD_REPEAT" ]]; then
		echo "Full disk encryption passwords do not match"
		exit 1
	fi
}

# Check if flake profile exists
# $1: flake identifier
check_flake() {
	FLAKE="${1}"
	FLAKE_PROFILE_PATH="hosts/${1}/default.nix"
	if [[ ! -f "$FLAKE_PROFILE_PATH" ]]; then
		echo "Flake not found by ID:"
		echo -e "\t$FLAKE -> $FLAKE_PROFILE_PATH"
		exit 1
	fi
}

# Check if secret exists
# $1: path to secret file
check_secret_path() {
	SOPS_SECRET_PATH="$1"
	if [[ ! -f "$SOPS_SECRET_PATH" ]]; then
		echo "No secret file found:"
		echo -e "\t$SOPS_SECRET_PATH"
		exit 1
	fi
}



echo "=== NixOS Anywhere Installer ==="
echo

# Interactive user prompt
read -rp "SSH destination host: " SSH_HOST
read -rp "SSH destination port [22]: " SSH_PORT
SSH_PORT=${SSH_PORT:-22}
read -rp "SSH user (requires sudo privileges) [nixos]: " SSH_USER
SSH_USER=${SSH_USER:-"nixos"}
read -srp "SSH password: " SSH_PW
echo
read -rp "Nix flake: " FLAKE
check_flake "$FLAKE"
read -rp "Host secret SOPS file: " HOST_SOPS_SECRET
check_secret_path "$HOST_SOPS_SECRET"
read -rp "User secret SOPS file: " USER_SOPS_SECRET
check_secret_path "$USER_SOPS_SECRET"
read -srp "Full disk encryption password: " LUKS_PASSWORD
echo
read -srp "Full disk encryption password (repeat): " LUKS_PASSWORD_REPEAT
check_pw_match "$LUKS_PASSWORD" "$LUKS_PASSWORD_REPEAT"
echo

# Setup of secrets
temp=$(mktemp -d)
# Host secrets
install -d -m700 "$temp/secrets"
sops decrypt \
	--extract '["host_key"]' \
	--output "$temp/secrets/keys.txt" \
	"$(realpath --canonicalize-existing --quiet "$HOST_SOPS_SECRET")"
chmod 600 "$temp/secrets/keys.txt"
# Setup user key
install -d -m700 "$temp/home/rtucek/.config/sops/age"
sops decrypt \
	--extract '["age_key"]' \
	--output "$temp/home/rtucek/.config/sops/age/keys.txt" \
	"$(realpath --canonicalize-existing --quiet "$USER_SOPS_SECRET")"
chmod 600 "$temp/home/rtucek/.config/sops/age/keys.txt"

echo
echo "Installing ${FLAKE}..."
echo

HW_CONFIG="hosts/${FLAKE}/hardware-configuration.nix"
echo "throw \"hardware-configuration.nix not yet auto-generated during setup\"" > "$HW_CONFIG"
SSHPASS="$SSH_PW" nix run github:nix-community/nixos-anywhere -- \
	--env-password \
	--extra-files "$temp" \
	--chown "/home/rtucek" "1000:100" \
	--disk-encryption-keys /tmp/disk.key <( echo "$LUKS_PASSWORD" ) \
	--generate-hardware-config nixos-generate-config "$HW_CONFIG" \
	--flake ".#${FLAKE}" \
	--target-host "${SSH_USER}@${SSH_HOST}" \
	--ssh-port "$SSH_PORT"

echo
echo "Installation finished."
echo "hardware-configuration.nix generated in $HW_CONFIG"
