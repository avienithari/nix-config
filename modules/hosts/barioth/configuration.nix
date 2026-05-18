{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.networkmanager.enable = true;

  console.keyMap = "pl2";

  environment.systemPackages = with pkgs; [
  ];
}
