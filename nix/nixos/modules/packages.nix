{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi
    _1password-gui-beta
    brave
  ];
}
