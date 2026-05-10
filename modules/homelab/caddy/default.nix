{ ... }:

{
  services.caddy = {
    enable = true;
    globalConfig = ''
      servers {
        trusted_proxies static 127.0.0.1
      }
    '';

    extraConfig = ''
      (security_headers) {
        header {
          Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
          X-Content-Type-Options "nosniff"
          X-Frame-Options "SAMEORIGIN"
          Referrer-Policy "strict-origin-when-cross-origin"

          -Server
          -Via
          -X-Powered-By
        }
      }

      (lan_only) {
        @external {
          not remote_ip 127.0.0.1 192.168.0.0/24 100.64.0.0/10
        }
        abort @external
      }
    '';

    virtualHosts."http://, https://" = {
      extraConfig = ''
        abort
      '';
    };
  };
}
