{ config, pkgs, secrets, ... }:

let
  private = import "${secrets}/private.nix";
  domain = private.acme.domain;
  excalidraw = pkgs.callPackage ./excalidraw-pkg.nix { };
in
{
  services.caddy.virtualHosts."draw.${domain}" = {
    useACMEHost = domain;
    extraConfig = ''
      root * ${excalidraw}/share/excalidraw
      file_server
    '';
  };
}
