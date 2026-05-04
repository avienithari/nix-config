{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.host.feature.torrent {
    environment.systemPackages = with pkgs; [
      deluge
    ];
  };
}
