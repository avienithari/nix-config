{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bluetui
    bluez
  ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
