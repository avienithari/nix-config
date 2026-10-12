{ secrets, ... }:

let
  private = import "${secrets}/private.nix";
  domain = private.services.actual.domain;
  port = private.services.actual.port;
in
{
  services = {
    actual = {
      enable = true;
      settings = {
        inherit port;
      };
    };

    caddy.virtualHosts."budget.${domain}" = {
      useACMEHost = domain;
      extraConfig = ''
        import security_headers
        import lan_only
        reverse_proxy 127.0.0.1:${toString port}
      '';
    };
  };
}
