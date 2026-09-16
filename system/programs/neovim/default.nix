{ lib, pkgs, ... }:
let
  nvim = "${lib.getExe pkgs.neovim}";
in
{
  environment = {
    variables.EDITOR = nvim;
    sessionVariables.EDITOR = nvim;
  };
}
