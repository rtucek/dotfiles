{ config, ... }:
let
  checkXdphSupport =
    fallbackCfg:
    if config.wayland.windowManager.hyprland ? xdph then
      throw ''
        `wayland.windowManager.hyprland.xdph` is now available!
        Remove the home manager workaround!
      ''
    else
      fallbackCfg;
in
{
  xdg.configFile.xdph = checkXdphSupport {
    target = "hypr/xdph.conf";
    text = ''
      screencopy {
          allow_token_by_default = true
      }
    '';
  };
  # This should rather be done like below. However, `wayland.windowManager.hyprland.xdph`, is
  # currently unavailable on the stable 26.05 channel.
  # Hence, we're for now managing the config on our own via home manager, but will change it, once
  # the property is available with the next-best stable release.
  # Eventually, this is what we want:
  # wayland.windowManager.hyprland.xdph = {
  #   # https://nix-community.github.io/home-manager/options/home-manager/wayland.html?highlight=xdph#opt-wayland.windowManager.hyprland.xdph.settings
  #   settings = {
  #     screencopy = {
  #       # default is 120 -> override a lower value if needed (video stuttering, visual artifacts and alike...).
  #       # max_fps = 120;
  #       allow_token_by_default = true;
  #     };
  #   };
  # };
}
