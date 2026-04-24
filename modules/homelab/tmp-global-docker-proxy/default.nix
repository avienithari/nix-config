{ secrets, ... }:

let
  private = import "${secrets}/private.nix";
  domain = private.acme.domain;
  nasAddress = private.services.nasAddress;
in
{
  services.caddy = {
    enable = true;

    virtualHosts = {
      "home.${domain}" = {
        useACMEHost = domain;
        extraConfig = ''
          reverse_proxy 127.0.0.1:8123
        '';
      };

      "nas.${domain}" = {
        useACMEHost = domain;
        extraConfig = ''
          reverse_proxy ${nasAddress}:80
        '';
      };

      "navidrome.${domain}" = {
        useACMEHost = domain;
        extraConfig = ''
          reverse_proxy 127.0.0.1:4533
        '';
      };

      "strings.${domain}" = {
        useACMEHost = domain;
        extraConfig = ''
          reverse_proxy 127.0.0.1:4500
        '';
      };
    };
  };
}
