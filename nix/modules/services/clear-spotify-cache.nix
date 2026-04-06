{ pkgs, ... }:

{
  systemd.services.clear-spotify-cache = {
    serviceConfig.Type = "oneshot";
    path = with pkgs; [ bash ];
    script = ''
      bash /home/avien/.config/scripts/clear-spotify-cache.sh
    '';
  };

  systemd.timers.clear-spotify-cache = {
    wantedBy = [ "timers.target" ];
    partOf = [ "clear-spotify-cache.service" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      Unit = "clear-spotify-cache.service";
    };
  };
}
