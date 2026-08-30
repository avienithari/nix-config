{ secrets, ... }:

let
  private = import "${secrets}/private.nix";
  domain = private.services.navidrome.domain;
  port = private.services.navidrome.port;
  share = private.services.nas.shares.media;
  library = "/mnt/media/music";
in
{
  services = {
    navidrome = {
      enable = true;
      openFirewall = true;
      settings = {
        Address = "127.0.0.1";
        Port = port;
        MusicFolder = library;
      };
    };

    caddy.virtualHosts."music.${domain}" = {
      useACMEHost = domain;
      extraConfig = ''
        import security_headers
        import lan_only
        reverse_proxy 127.0.0.1:${toString port}
      '';
    };
  };

  homelab.per-service-smb."media" = {
    inherit share;
    uid = "navidrome";
  };

  systemd.services.media = {
    requires = [ "mnt-media.automount" ];
    after = [ "mnt-media.automount" ];
  };
}
