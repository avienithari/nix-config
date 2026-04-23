{ secrets, ... }:

let
  private = import "${secrets}/private.nix";
  domain = private.acme.domain;
in
{
  services = {
    silverbullet = {
      enable = true;
      listenPort = 8083;
    };

    caddy.virtualHosts."notes.${domain}" = {
      useACMEHost = domain;
      extraConfig = ''
        reverse_proxy 127.0.0.1:8083
      '';
    };
  };
}
