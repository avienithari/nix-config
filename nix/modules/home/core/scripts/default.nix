{ lib, pkgs, vars, ... }:

let
  loadScript = path: import path { inherit pkgs; };
in
{
  home.packages = (map loadScript [
    ./sessionizer.nix
    ./ytd.nix
  ])
  ++ lib.optionals (vars.class != "server") (map loadScript [
    ./clear-spotify-cache.nix
  ])
  ++ lib.optionals (vars.class == "laptop") (map loadScript [
    ./acpi-loop.nix
    ./battery-status.nix
  ]);
}
