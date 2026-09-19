{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (import ./bt-devices.nix { inherit lib pkgs; }) btDevices bluetoothctl;

  btConnFuncs = map (dev: ''
    bt-connect-${dev.name}() {
      ${bluetoothctl} connect ${dev.mac}
    }
    bt-disconnect-${dev.name}() {
      ${bluetoothctl} disconnect ${dev.mac}
    }
  '') btDevices;
in
{
  programs.bash = {
    enable = true;

    enableCompletion = true;

    initExtra = ''
      ${builtins.concatStringsSep "\n" btConnFuncs}

      # Add go's bin directory to path
      #
      # For the record: doing something like this would be more idiomatic...
      # ```nix
      # home.sessionPath = [
      #  # Add ~/go/bin to $PATH
      #  "${config.home.homeDirectory}/go/bin"
      # ];
      # ```
      # ... but unfortunately, this doesn't work for reasons, outlined in
      # https://github.com/nix-community/home-manager/issues/4969 and
      # https://github.com/nix-community/home-manager/issues/4559, so we're using this workaround
      # below \o/
      if [[ ":$PATH:" != *":$HOME/go/bin:"* ]]; then
        export PATH="$PATH:$HOME/go/bin"
      fi
    '';
  };
}
