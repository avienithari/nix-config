{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.host.isGuiHost && config.host.feature.bloat) {
    environment.systemPackages = with pkgs; [
      burpsuite
      libreoffice
    ];
  };
}
