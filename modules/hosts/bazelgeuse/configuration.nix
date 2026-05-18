{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
  ];
}
