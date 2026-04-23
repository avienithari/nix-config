{ secrets, ... }:

let
  private = import "${secrets}/private.nix";
  domain = private.acme.domain;
in
{
  services = {
    uptime-kuma = {
      enable = true;
      settings = {
        PORT = "3001";
        HOST = "127.0.0.1";
      };
    };

    caddy.virtualHosts."uptime.${domain}" = {
      useACMEHost = domain;
      extraConfig = ''
        reverse_proxy 127.0.0.1:3001
      '';
    };
  };
}
