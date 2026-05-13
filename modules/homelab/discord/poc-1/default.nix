{ config, pkgs, secrets, username, ... }:

let
  poc1EnvPath = config.age.secrets.d-poc-1.path;
  discordPoc1 = pkgs.python3.withPackages (ps: with ps; [
    requests
    python-dotenv
    discordpy
  ]);
in
{
  age.secrets."d-poc-1".file = "${secrets}/d-poc-1.age";

  systemd.services."discord-poc-1" = {
    description = "Discord _get rid of docker_ PoC 1";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    path = [ discordPoc1 ];

    serviceConfig = {
      Type = "simple";
      User = "${username}";
      WorkingDirectory = "/home/${username}/docker-pocs/poc-1";
      EnvironmentFile = poc1EnvPath;
      Environment = "PYTHONUNBUFFERED=1";
      ExecStart = "${discordPoc1}/bin/python main.py";
      Restart = "always";
    };
  };
}
