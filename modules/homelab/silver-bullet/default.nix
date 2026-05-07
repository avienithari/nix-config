{ config, secrets, ... }:

let
  silverbulletPath = config.age.secrets.silverbullet.path;

  private = import "${secrets}/private.nix";
  domain = private.acme.domain;
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
      listenPort = 8083;
      envFile = silverbulletPath;
    };

    caddy.virtualHosts."notes.${domain}" = {
      useACMEHost = domain;
      extraConfig = ''
        import security_headers
        import lan_only
        reverse_proxy 127.0.0.1:8083
      '';
    };
  };
}
