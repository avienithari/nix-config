{ config, secrets, ... }:

let
  silverbulletPath = config.age.secrets.silverbullet.path;

  private = import "${secrets}/private.nix";
  domain = private.services.silverbullet.domain;
  port = private.services.silverbullet.port;
in
{
  age.secrets."silverbullet" = {
    file = "${secrets}/silverbullet.age";
    owner = "silverbullet";
    group = "silverbullet";
  };

  services = {
    silverbullet = {
      enable = true;
      listenPort = port;
      envFile = silverbulletPath;
    };

    caddy.virtualHosts."notes.${domain}" = {
      useACMEHost = domain;
      extraConfig = ''
        import security_headers
        import lan_only
        reverse_proxy 127.0.0.1:${toString port}
      '';
    };
  };
}
