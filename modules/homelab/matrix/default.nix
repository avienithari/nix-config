{ config, pkgs, secrets, ... }:

let
  cfTunnelPath = config.age.secrets.matrix-tunnel.path;
  matrixMacaroon = config.age.secrets.matrix-macaroon.path;
  matrixRegistration = config.age.secrets.matrix-registration.path;

  private = import "${secrets}/private.nix";
  port = private.matrix.hostPort;

  domain = private.matrix.domain;
  matrixDomain = "matrix.${domain}";

  matrixClientWellKnown = pkgs.writeTextDir ".well-known/matrix/client" ''
    {
      "m.homeserver": {
        "base_url": "https://${matrixDomain}"
      }
    }
  '';
in
{
  age.secrets = {
    "matrix-tunnel".file = "${secrets}/matrix-tunnel.age";
    "matrix-macaroon" = {
      file = "${secrets}/matrix-macaroon.age";
      owner = "matrix-synapse";
      group = "matrix-synapse";
    };
    "matrix-registration" = {
      file = "${secrets}/matrix-registration.age";
      owner = "matrix-synapse";
      group = "matrix-synapse";
    };
  };

  services = {
    matrix-synapse = {
      enable = true;
      settings = {
        server_name = domain;
        public_baseurl = "https://${matrixDomain}";

        registration_shared_secret_path = matrixRegistration;
        macaroon_secret_key_path = matrixMacaroon;

        enable_registration = false;
        allow_guest_access = false;
        federation_enabled = false;
        federation_domain_whitelist = [ ];
        allow_public_rooms_over_federation = false;
        allow_profile_lookup_over_federation = false;
        allow_device_name_lookup_over_federation = false;

        enable_metrics = false;
        max_upload_size = "100M";
        url_preview_enabled = true;
        delete_stale_devices_after = "1w";

        password_config = {
          enabled = true;
          policy = {
            enabled = true;
            minimum_length = 32;
            require_digit = true;
            require_symbol = true;
            require_lowercase = true;
            require_uppercase = true;
          };
        };

        database = {
          name = "psycopg2";
          allow_unsafe_locale = true;
          args = {
            user = "matrix-synapse";
            database = "matrix-synapse";
            host = "/run/postgresql";
          };
        };

        listeners = [
          {
            port = 8008;
            bind_addresses = [ "127.0.0.1" "::1" ];
            type = "http";
            tls = false;
            x_forwarded = true;
            resources = [
              {
                names = [ "client" ];
                compress = true;
              }
            ];
          }
        ];
      };
    };

    postgresql = {
      enable = true;
      ensureDatabases = [ "matrix-synapse" ];
      ensureUsers = [
        {
          name = "matrix-synapse";
          ensureDBOwnership = true;
        }
      ];
    };

    caddy = {
      enable = true;
      virtualHosts.":${port}" = {
        extraConfig = ''
          import security_headers

          handle /.well-known/matrix/client {
            header Access-Control-Allow-Origin "*"

            root * ${matrixClientWellKnown}
            file_server
          }

          handle /.well-known/matrix/server {
            abort
          }

          handle /_matrix/federation* {
            abort
          }

          handle /_matrix/static* {
            abort
          }

          handle / {
            abort
          }

          handle {
            reverse_proxy 127.0.0.1:8008
          }
        '';
      };
    };

    cloudflared = {
      enable = true;
      tunnels = {
        "matrix" = {
          credentialsFile = cfTunnelPath;
          default = "http_status:404";
          ingress = {
            "${matrixDomain}" = "http://127.0.0.1:${port}";
          };
        };
      };
    };
  };
}
