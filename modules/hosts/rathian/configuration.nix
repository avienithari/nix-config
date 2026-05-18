{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.networkmanager.enable = true;

  users.users.avien = {
    isNormalUser = true;
    description = "avien";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  environment.systemPackages = with pkgs; [
  ];
}
