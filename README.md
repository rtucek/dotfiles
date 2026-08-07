# Dotfiles

My dotfiles (and now, system configuration) - use them as a reference for your personal use and
contribute suggestions and improvements.

As of 2026, I've switched from an [Arch-based](https://archlinux.org/) setup, where dotfiles were
managed with [Chezmoi](https://www.chezmoi.io/), to [NixOS](https://nixos.org/) via a flake-based
approach.

Dotfiles in the home directory - including most tools whenever possible - are managed via [Home
Manager](https://nix-community.github.io/home-manager/).

Historical Arch configuration may be inspected by looking at the
[arch-dotfiles](https://github.com/rtucek/dotfiles/releases/tag/arch-dotfiles) tag.


## Installation

While this is technically "just" a glorified Nix flake, the initial installation on a host requires
some bootstrapping.

This is due to the following requirements:
- disk partitioning is declaratively managed via disko.[^disko docs]
- secret management is achieved via sops-nix.[^sops-nix docs]
- installation via nixos-anywhere.[^nixos-anywhere docs]


### Onboarding a new machine

Assuming you want to add a new machine from scratch, perform the following steps in order:


#### Settle on the hostname

The computer's hostname is a key parameter in NixOS as it maps (by default) to the configuration
target.

The example below adds a new laptop of type TUXEDO InfinityBook Pro AMD Gen9. As such, it uses
`tux-ibp-amdgen9-nixos-btw` as the hostname.


#### Create a host key

The host key is required for decrypting secrets at boot time.
For security reasons, each host is expected to have its own dedicated key, located at
`/secrets/keys.txt`.

In order to generate a new key, run:

```sh
age-keygen -pq
```

This will dump an age identity - both the public and private keys - to stdout.[^age docs]
Store the output in a temporary file.


#### Create the host SOPS file

Create a dedicated SOPS file for encrypting the host key. The general convention is to locate the
host key in `./secrets/hosts/${HOSTNAME}.yaml`.

```
# Create the file via
sops edit ./secrets/hosts/tux-ibp-amdgen9-nixos-btw.yaml
```

Then, add the previously generated age key in the `host_key` mapping:

```yaml
host_key: |
  # created: 2026-08-05T20:01:32+02:00
  # public key:age1pq1f7nk5g0hcvy52[...]appfzrumnuawfy5mdlqd
  AGE-SECRET-KEY-PQ-[...]
```


#### Update secrets with the new key

With the new key, the host won't be able to decrypt existing secrets. Existing secrets can only be
decrypted once they have been re-encrypted with the new public key.

Before being able to re-encrypt secrets, the new public key must be configured in `.sops.yaml`. Add
the new public key as a YAML anchor to `keys.hosts.${HOSTNAME}` and alias the value as
`${HOSTNAME}_age`.

```yaml
keys:
  hosts:
    # [...]
    tux-ibp-amdgen9-nixos-btw: &tux-ibp-amdgen9-nixos-btw_age |
      age1pq1f7nk5g0hcvy52[...]appfzrumnuawfy5mdlqd
```

Then, reference the new key in the default creation rule in `creation_rules.key_groups.age`:

```yaml
creation_rules:
  - key_groups:
      age:
      # [...]
      - *tux-ibp-amdgen9-nixos-btw_age
```

Finally, re-encrypt all secrets with the new key by running:

```sh
sops updatekeys ./secrets/**.yaml
```

You should see all relevant secret files updated in the secrets folder. A notable exception may be
secrets, for which other exclusive creation rules take precedence.


#### Extend the flake

First, make sure you add the baseline configuration by creating
`hosts/tux-ibp-amdgen9-nixos-btw/default.nix` (the convention is `hosts/${HOSTNAME}/default.nix`).

Paste the following template into it.

```nix
{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common/users/rtucek.nix
  ];

  networking.hostName = "tux-ibp-amdgen9-nixos-btw";
  sops.defaultSopsFile = ../../secrets/hosts/tux-ibp-amdgen9-nixos-btw.yaml;

  # If applicable, configure the default screens resolution below.
  # home-manager.users.rtucek = {
  #   wayland.windowManager.hyprland.settings = {
  #     monitor = [
  #       {
  #         output = "eDP-1";
  #         mode = "2880x1800@120.0000";
  #         position = "0x0";
  #         scale = 1.5;
  #       }
  #     ];
  #   };
  # };

  # If applicable, change the default LV size.
  # disko.devices.lvm_vg.volgroup0.lvs = {
  #   # 250 GB of available disk space
  #   lv_root.size = "250G";
  #   # 250 GB of available disk space
  #   lv_home.size = "250G";
  # };
}
```

The referenced `hardware-configuration.nix` file must be present. The actual content will be
generated during the installation by `nixos-anywhere`. It is sufficient to write the following
content to `hosts/tux-ibp-amdgen9-nixos-btw/hardware-configuration.nix` (the convention is
`hosts/${HOSTNAME}/hardware-configuration.nix`):

```nix
{ lib, ... }:
{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
```

Finally, make sure the host configuration is imported in `hosts/default.nix`. Use the following
template:

```nix
{ self, inputs, ... }:
{
  flake.nixosConfigurations =
    let
      sys = "${self}/system";

      # [...]

      specialArgs = { inherit inputs self; };
    in
    {
      # [...]

      tux-ibp-amdgen9-nixos-btw = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;

        modules =
          laptop
          ++ commonCfg
          ++ [
            ./tux-ibp-amdgen9-nixos-btw
          ];
      };
    };
}
```

Once finished, run `nix flake check .` to verify that the configuration changes are still valid.


#### Prepare the destination host

SSH into the installation target via `ssh user@IP` and verify that you have sudo privileges by
running `sudo whoami`.

As a general reminder, it is also advisable to verify the available disk size (e.g. `sudo fdisk -l
/dev/[...]`). If necessary, adjust `disko.devices.lvm_vg.volgroup0.lvs.lv_root.size` and
`disko.devices.lvm_vg.volgroup0.lvs.lv_home.size` accordingly.


#### Do the installation

Once everything is ready, simply run `./nix-install.sh` and follow the interactive installer.

The installer will prompt you for the full-disk-encryption password.

> WARNING: `./nix-install.sh` will format the destination host's disk via disko. Make sure you have
> backed up your machine in case something breaks during the installation.

During the installation, `hosts/tux-ibp-amdgen9-nixos-btw/hardware-configuration.nix` will be
rewritten, based on the detected hardware. Don't forget to commit the updated file!


[^disko docs]: https://github.com/nix-community/disko
[^sops-nix docs]: https://github.com/mic92/sops-nix
[^nixos-anywhere docs]: https://nix-community.github.io/nixos-anywhere
[^age docs]: https://age-encryption.org/
