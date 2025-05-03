{ config, lib, ... }:

{
  imports = [
    ./configuration.nix
  ];

  networking.hostName = lib.mkForce "rathian";
}
