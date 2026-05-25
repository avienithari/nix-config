{ config, lib, ... }:

let
  cfg = config.host.feature.lld;
in
{
  config = lib.mkIf cfg {
    homebrew.brews = [
      "lld"
    ];
  };
}
