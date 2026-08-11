{ lib, pkgs, ... }:
let
  btDevices = [
    {
      # JBL Live 660NC
      name = "jbl-live";
      mac = "28:6F:40:16:35:A5";
    }
    {
      # JBL Tune 720BT
      name = "jbl-tune";
      mac = "00:A4:1C:0E:56:9A";
    }
    {
      # Ekosphear (Netflix)
      name = "ekosphear-private";
      mac = "00:02:5B:07:E8:96";
    }
  ];

  bluetoothctl = "${lib.getBin pkgs.bluez}/bin/bluetoothctl";
in
{
  inherit btDevices bluetoothctl;
}
