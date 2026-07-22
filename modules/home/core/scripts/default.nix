{ lib, pkgs, osConfig, ... }:

let
  cfg = osConfig.host;
  loadScript = path: import path { inherit pkgs; };
in
{
  home.packages = (map loadScript [
    ./notes-picker.nix
    ./sessionizer.nix
    ./ytd.nix
  ])
  ++ lib.optionals (cfg.class != "server") (map loadScript [
    ./chrono.nix
    ./clear-spotify-cache.nix
  ])
  ++ lib.optionals (cfg.class == "laptop") (map loadScript [
    ./acpi-loop.nix
    ./battery-status.nix
  ])
  ++ lib.optionals cfg.feature.nut.enable (map loadScript [
    ./ups-status.nix
  ])
  ++ lib.optionals (cfg.isWorkstation && cfg.class == "desktop")
    (map loadScript [
      ./remote.nix
    ]);
}
