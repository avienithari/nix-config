{ config, pkgs, secrets, username, ... }:

let
  poc2EnvPath = config.age.secrets.d-poc-2.path;
  discordPoc2 = pkgs.python3.withPackages (ps: with ps; [
    aiosqlite
    arrow
    dateparser
    discordpy
    packaging
    python-dateutil
    python-dotenv
    rich
    setuptools
    tomli
    uvloop
  ]);
in
{
  age.secrets."d-poc-2".file = "${secrets}/d-poc-2.age";

  systemd.services."discord-poc-2" = {
    description = "Discord _get rid of docker_ PoC 2";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    path = [ discordPoc2 ];

    serviceConfig = {
      Type = "simple";
      User = "${username}";
      WorkingDirectory = "/home/${username}/docker-pocs/poc-2";
      EnvironmentFile = poc2EnvPath;
      Environment = "PYTHONUNBUFFERED=1";
      ExecStart = "${discordPoc2}/bin/python start.py";
      Restart = "always";
    };
  };
}
