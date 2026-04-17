{ config, lib, ... }:

{
  config = lib.mkIf (config.host.isGuiHost && config.host.feature.steam) {
    programs.steam.enable = true;
  };
}
