{ lib, osConfig, ... }:

{
  imports = lib.optionals (osConfig.host.class != "server") [
    ./clear-spotify-cache.nix
  ];
}
