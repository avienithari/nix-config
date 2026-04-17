{ config, lib, pkgs, username, ... }:

{
  config = lib.mkIf config.host.feature.docker {
    environment.systemPackages = with pkgs; [
      docker-compose
    ];

    virtualisation.docker.enable = true;

    users.users.${username} = {
      extraGroups = [ "docker" ];
    };
  };
}
