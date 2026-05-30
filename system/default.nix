let
  desktop = [
    ./core

    ./hardware/fwupd.nix
    ./hardware/graphics.nix

    ./network
    ./network/avahi.nix

    ./programs

    ./services
    # TODO: coming soon
    # ./servcies/greetd.nix
    # ./services/pipewire.nix
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
