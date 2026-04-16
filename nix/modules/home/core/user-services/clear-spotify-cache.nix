{ pkgs, lib, ... }:

let
  clearSpotifyCache = import ../scripts/clear-spotify-cache.nix { inherit pkgs; };
in
{
  systemd.user.services.clear-spotify-cache = {
    Unit = {
      Description = "Clear Spotify Cache";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${lib.getExe clearSpotifyCache}";
    };
  };

  systemd.user.timers.clear-spotify-cache = {
    Unit = {
      Description = "Daily timer clearing Spotify Cache";
      PartOf = [ "clear-spotify-cache.service" ];
    };
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
      Unit = "clear-spotify-cache.service";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
