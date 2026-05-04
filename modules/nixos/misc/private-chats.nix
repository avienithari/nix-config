{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.host.feature.privateChats {
    environment.systemPackages = with pkgs; [
      element-desktop
      gajim
      signal-desktop
    ];
  };
}
