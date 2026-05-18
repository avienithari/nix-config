{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  console.keyMap = "pl2";

  environment.systemPackages = with pkgs; [
  ];
}
