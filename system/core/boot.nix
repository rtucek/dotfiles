{ pkgs, config, ... }:
{
  boot = {
    bootspec.enableValidation = true;

    initrd = {
      systemd.enable = true;

      # Managed via Disko
      # supportedFilesystems = [];
    };

    # Default to latest and greatest kernel by default.
    kernelPackages = pkgs.linuxPackages;

    # Typical kernel parameters, which we'd usually pass via GRUB's
    # `GRUB_CMDLINE_LINUX_DEFAULT`.
    #
    # Nothing at the moment... \o/
    # kernelParams = [];

    # Set console logging verbosity to KERN_ERR.
    # see https://www.kernel.org/doc/html/next/core-api/printk-basics.html
    consoleLogLevel = 3;

    # Use systemd-boot on UEFI instead of GRUB.
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  # Ensure cpupower is using the same version, as the current kernel.
  environment.systemPackages = [ config.boot.kernelPackages.cpupower ];
}
