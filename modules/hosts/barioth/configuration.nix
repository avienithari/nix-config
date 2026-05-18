{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  console.keyMap = "pl2";

  environment.systemPackages = with pkgs; [
  ];
}
