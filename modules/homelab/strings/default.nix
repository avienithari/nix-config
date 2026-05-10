{ pkgs, secrets, ... }:

let
  stringsPkgs = pkgs.callPackage ./strings-pkg.nix { };
  private = import "${secrets}/private.nix";
  domain = private.services.strings.domain;
  port = toString private.services.strings.port;
in
{
  systemd.services.strings = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      ExecStart = "${stringsPkgs}/bin/query-strings";
      Restart = "always";
      DynamicUser = true;
    };
  };

  services.caddy.virtualHosts."strings.${domain}" = {
    useACMEHost = domain;
    extraConfig = ''
      import security_headers
      import lan_only
      reverse_proxy 127.0.0.1:${port}
    '';
  };
}
