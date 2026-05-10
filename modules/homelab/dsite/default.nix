{ config, pkgs, secrets, ... }:

let
  cfTunnelPath = config.age.secrets.dsite-tunnel.path;
  private = import "${secrets}/private.nix";
  dsite = pkgs.callPackage ./dsite-pkg.nix { };
  domain = private.services.dsite.domain;
  port = toString private.services.dsite.port;
in
{
  age.secrets."dsite-tunnel".file = "${secrets}/dsite-tunnel.age";

  services = {
    caddy = {
      virtualHosts."http://www.${domain}:${port}" = {
        listenAddresses = [ "127.0.0.1" ];
        extraConfig = ''
          import security_headers
          redir * https://${domain}{uri} permanent
        '';
      };

      virtualHosts."http://${domain}:${port}" = {
        listenAddresses = [ "127.0.0.1" ];
        extraConfig = ''
          import security_headers
          root * ${dsite}
          try_files {path} /index.html
          file_server
          @static {
            path *.ico *.css *.js *.gif *.jpg *.jpeg *.png *.woff2 *.eot *.ttf *.svg *.otf *.map *.json
          }
          header @static Cache-Control "public, max-age=15552000"
        '';
      };
    };

    cloudflared = {
      enable = true;
      tunnels = {
        "dsite" = {
          credentialsFile = cfTunnelPath;
          default = "http_status:404";
          ingress = {
            "${domain}" = "http://127.0.0.1:${port}";
            "www.${domain}" = "http://127.0.0.1:${port}";
          };
        };
      };
    };
  };
}
