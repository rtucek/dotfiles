{
  inputs,
  home-manager,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.rtucek = ./home.nix;
  };

  networking.hostName = "nixos-btw";

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    # TODO: enable, once using home manager
    # vimdiffAlias = true;
    enableMan = true;
    enablePrintInit = true;
    waylandSupport = true;

    withNodeJs = true;
    withPerl = true;
    withPython3 = true;
    withRuby = true;

    editorconfig = {
      enable = true;
    };

    colorschemes.gruvbox.enable = true;
  };

  security.pam.services.hyprlock = {
    enable = true;
  };
}
