{ config, lib, pkgs, ... }:

let
  isWorkstation = config.host.isWorkstation;
in
{
  config = lib.mkIf isWorkstation {
    environment.systemPackages = with pkgs; [
      brave
      slack
    ];
  };
}
