{ config, lib, ... }:

let
  cfg = config.host.feature.steam;
in
{
  config = lib.mkIf cfg {
    homebrew.casks = [
      "steam"
    ];
  };
}
