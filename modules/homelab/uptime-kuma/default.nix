{ secrets, ... }:

let
  private = import "${secrets}/private.nix";
  domain = private.services.uptime-kuma.domain;
  port = toString private.services.uptime-kuma.port;
in
{
  services = {
    uptime-kuma = {
      enable = true;
      settings = {
        PORT = port;
        HOST = "127.0.0.1";
      };
    };

    caddy.virtualHosts."uptime.${domain}" = {
      useACMEHost = domain;
      extraConfig = ''
        import security_headers
        import lan_only
        reverse_proxy 127.0.0.1:${port}
      '';
    };
  };
}
