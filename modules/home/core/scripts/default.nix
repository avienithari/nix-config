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
    ./chrono.nix
    ./clear-spotify-cache.nix
  ])
  ++ lib.optionals (osConfig.host.class == "laptop") (map loadScript [
    ./acpi-loop.nix
    ./battery-status.nix
  ])
  ++ lib.optionals osConfig.host.feature.nut.enable (map loadScript [
    ./ups-status.nix
  ])
  ++ lib.optionals (osConfig.host.isWorkstation && osConfig.host.class == "desktop") (map loadScript [
    ./remote.nix
  ]);
}
