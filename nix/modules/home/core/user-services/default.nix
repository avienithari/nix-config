{ lib, vars, ... }:

{
  imports = [ ]
    ++ lib.optionals (vars.class != "server") [
    ./clear-spotify-cache.nix
  ];
}
