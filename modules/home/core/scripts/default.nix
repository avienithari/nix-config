{ lib, pkgs, osConfig, ... }:

let
  loadScript = path: import path { inherit pkgs; };
in
{
  home.packages = (map loadScript [
    ./notes-picker.nix
    ./sessionizer.nix
    ./ytd.nix
  ])
  ++ lib.optionals (osConfig.host.class != "server") (map loadScript [
    ./clear-spotify-cache.nix
  ])
  ++ lib.optionals (osConfig.host.class == "laptop") (map loadScript [
    ./acpi-loop.nix
    ./battery-status.nix
  ])
  ++ lib.optionals osConfig.host.feature.nut.enable (map loadScript [
    ./ups-status.nix
  ]);
}
