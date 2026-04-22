{ config, pkgs, secrets, ... }:

let
  cfTunnelPath = config.age.secrets.xmpp-tunnel.path;

  private = import "${secrets}/private.nix";
  port = private.xmpp.hostPort;

  domain = private.xmpp.domain;
  xmppDomain = "xmpp.${domain}";
  mucDomain = "muc.${xmppDomain}";
  uploadDomain = "upload.${domain}";

  hostMeta = pkgs.writeTextDir ".well-known/host-meta" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <XRD xmlns="http://docs.oasis-open.org/ns/xri/xrd-1.0">
      <Link rel="urn:xmpp:alt-connections:websocket"
            href="wss://${xmppDomain}/xmpp-websocket"/>
    </XRD>
  '';
in
{
  age.secrets."xmpp-tunnel".file = "${secrets}/xmpp-tunnel.age";

  services = {
    prosody = {
      enable = true;
      admins = [ "${private.xmpp.adminPrefix}@${xmppDomain}" ];

      virtualHosts.${xmppDomain} = {
        enabled = true;
        domain = xmppDomain;
      };

      muc = [
        {
          domain = mucDomain;
          name = "Chat Room";
          restrictRoomCreation = false;
        }
      ];

      httpFileShare = {
        domain = uploadDomain;
        size_limit = 100 * 1024 * 1024;
      };

      modules = {
        admin_adhoc = true;
        carbons = true;
        disco = true;
        mam = true;
        ping = true;
        roster = true;
        saslauth = true;
        websocket = true;
      };

      authentication = "internal_hashed";
      allowRegistration = false;
      httpPorts = [ 5280 ];
      httpInterfaces = [ "127.0.0.1" "::1" ];
      c2sRequireEncryption = false;

      extraConfig = ''
        Lua.table.insert(modules_enabled, "user_account_management")

        trusted_proxies = { "127.0.0.1", "::1" }

        http_external_url = "https://${xmppDomain}"

        consider_websocket_secure = true
        http_cors_override = {
            websocket = {
                enabled = true
            },
            file_share = {
                enabled = true
            },
        }

        c2s_ports = {}
        s2s_ports = {}

        Component "${uploadDomain}"
        http_external_url = "https://${uploadDomain}"
      '';
    };

    caddy = {
      enable = true;
      virtualHosts.":${port}" = {
        extraConfig = ''
          handle /.well-known/* {
            root * ${hostMeta}
            file_server
          }

          handle {
            reverse_proxy 127.0.0.1:5280
          }
        '';
      };
    };

    cloudflared = {
      enable = true;
      tunnels = {
        "xmpp" = {
          credentialsFile = cfTunnelPath;
          default = "http_status:404";
          ingress = {
            "${xmppDomain}" = "http://127.0.0.1:${port}";
            "${uploadDomain}" = "http://127.0.0.1:${port}";
          };
        };
      };
    };
  };
}
