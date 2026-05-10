{ pkgs, secrets, ... }:

let
  private = import "${secrets}/private.nix";
  domain = private.services.excalidraw.domain;
  excalidraw = pkgs.callPackage ./excalidraw-pkg.nix { };
in
{
  services.caddy.virtualHosts."draw.${domain}" = {
    useACMEHost = domain;
    extraConfig = ''
      import security_headers
      import lan_only
      root * ${excalidraw}/share/excalidraw
      file_server
    '';
  };
}
