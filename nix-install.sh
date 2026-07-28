#/bin/bash

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
for CMD in sops nix mktemp install; do
	require "$CMD"
done

echo "=== NixOS Anywhere Installer ==="
echo

# Interactive user prompt
read -rp "SSH destination host: " SSH_HOST
read -rp "SSH destination port [22]: " SSH_PORT
SSH_PORT=${SSH_PORT:-22}
read -rp "SSH user (requires sudo privileges): " SSH_USER
read -srp "SSH password: " SSH_PW
echo ""
read -rp "Nix flake: " FLAKE

HOST_SECRET="secrets/hosts/${FLAKE}.yaml"
HW_CONFIG="hosts/${FLAKE}/hardware-configuration.nix"
echo "throw \"hardware-configuration.nix not yet auto-generated during setup\"" > $HW_CONFIG

# Minimalistic validation
if [[ ! -f "$HOST_SECRET" ]]; then
	echo "No host secret found:"
	echo -e "\t$HOST_SECRET"
	exit 1
fi

# Setup of secrets
temp=$(mktemp -d)
# Host secrets
install -d -m700 "$temp/secrets"
sops decrypt \
	--extract '["host_key"]' \
	--output "$temp/secrets/keys.txt" \
	"$HOST_SECRET"
chmod 600 "$temp/secrets/keys.txt"
# Setup user key
install -d -m700 "$temp/home/rtucek/.config/sops/age"
sops decrypt \
	--extract '["age_key"]' \
	--output "$temp/home/rtucek/.config/sops/age/keys.txt" \
	secrets/users/rtucek.yaml
chmod 600 "$temp/home/rtucek/.config/sops/age/keys.txt"

echo
echo "Installing ${FLAKE}..."
echo

SSHPASS="$SSH_PW" nix run github:nix-community/nixos-anywhere -- \
	--env-password \
	--extra-files "$temp" \
	--chown "/home/rtucek" "1000:100" \
	--disk-encryption-keys \
		/tmp/disk.key \
		<( \
			sops decrypt \
				--extract '["luks_key"]' \
				"$HOST_SECRET"
		) \
	--generate-hardware-config nixos-generate-config "$HW_CONFIG" \
	--flake ".#${FLAKE}" \
	--target-host "${SSH_USER}@${SSH_HOST}" \
	--ssh-port "$SSH_PORT"

echo
echo "Installation finished."
echo "hardware-configuration.nix generated in $HW_CONFIG"
