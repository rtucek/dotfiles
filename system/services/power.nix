{
  services = {
    logind = {
      enable = true;

      settings.Login = {
        SleepOperation = "suspend-then-hibernate suspend";
        HandlePowerKey = "suspend";
        HandlePowerKeyLongPress = "poweroff";
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "suspend";
        HandleLidSwitchDocked = "suspend";
      };
    };

    auto-cpufreq = {
      enable = true;
    };

    upower = {
      enable = true;
    };
  };
}
