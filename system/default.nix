let
  desktop = [
    ./core

    ./hardware/fwupd.nix
    ./hardware/graphics.nix
    ./hardware/sound.nix

    ./network
    ./network/avahi.nix

    ./programs

    ./services
  ];

  laptop = desktop ++ [
    ./hardware/bluetooth.nix

    ./services/blacklight.nix
    ./services/power.nix
  ];
in
{
  inherit desktop laptop;
}
