{ ... }:
{
  imports = [
    ./boot.nix
    ./i18n.nix
    ./ram.nix
    ./security
    ./time.nix
    ./users.nix

    ../nix
  ];
}
