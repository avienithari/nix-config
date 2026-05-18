{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
  ];
}
