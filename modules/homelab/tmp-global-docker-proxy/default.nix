{ secrets, ... }:

let
  private = import "${secrets}/private.nix";
  domain = private.domains.lan;
  homeAssistantPort = toString private.services.home-assistant.port;
  nasAddress = private.services.nas.ip;
  nasPort = toString private.services.nas.port;
  navidromePort = toString private.services.navidrome.port;
  stringsPort = toString private.services.strings.port;
in
{
  services.caddy = {
    enable = true;

    virtualHosts = {
      "home.${domain}" = {
        useACMEHost = domain;
        extraConfig = ''
          import security_headers
          import lan_only
          reverse_proxy 127.0.0.1:${homeAssistantPort}
        '';
      };

      "nas.${domain}" = {
        useACMEHost = domain;
        extraConfig = ''
          import security_headers
          import lan_only
          reverse_proxy ${nasAddress}:${nasPort}
        '';
      };

      "navidrome.${domain}" = {
        useACMEHost = domain;
        extraConfig = ''
          import security_headers
          import lan_only
          reverse_proxy 127.0.0.1:${navidromePort}
        '';
      };

      "strings.${domain}" = {
        useACMEHost = domain;
        extraConfig = ''
          import security_headers
          import lan_only
          reverse_proxy 127.0.0.1:${stringsPort}
        '';
      };
    };
  };
}
