{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.hyprpwcenter
  ];

  services.pipewire = {
    enable = true;
    audio.enable = true;

    wireplumber.enable = true;
    alsa.enable = true;
    jack.enable = true;
    pulse.enable = true;
  };
}
