{ pkgs, username, ... }:

let
  pocLuajit = pkgs.luajit.withPackages (ps: with ps; [
    cjson
    http
    inspect
    basexx
    luaossl
  ]);
in
{
  systemd = {
    services."calendar-poc" = {
      description = "Calendar PoC";
      path = [
        pocLuajit
        pkgs.coreutils
      ];
      serviceConfig = {
        Type = "oneshot";
        User = "${username}";
        WorkingDirectory = "/home/${username}/calendar";
        ExecStart =
          "${pkgs.bash}/bin/bash -c 'echo \"Log: $(date)\" >> ./testies.log && luajit main.lua'";
      };
    };

    timers."calendar-poc" = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* *:00:00";
        Persistent = true;
        Unit = "calendar-poc.service";
      };
    };
  };
}
