{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.host.feature.useZsa {
    environment.systemPackages = with pkgs; [
      wally-cli
    ];

    hardware.keyboard.zsa.enable = true;
  };
}
