{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  console.keyMap = "pl2";

  users.users.avien = {
    isNormalUser = true;
    description = "avien";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  environment.systemPackages = with pkgs; [
  ];
}
