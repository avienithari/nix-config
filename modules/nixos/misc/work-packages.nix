{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.host.isWorkstation {
    environment.systemPackages = with pkgs; [
      brave
      slack
      termdown
    ];
  };
}
