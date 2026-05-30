{ pkgs, ... }:
{
  users.users.rtucek = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel" # sudo make me a sandwich
    ];
  };

  programs.fish.enable = true;
}
