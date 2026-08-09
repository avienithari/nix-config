{ pkgs, lib, ... }:

let
  rose-pine-gtk-theme =
    pkgs.callPackage ./rose-pine-gtk-theme-pkg.nix { };
in
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = lib.mkForce {
      name = "rose-pine";
      package = rose-pine-gtk-theme;
    };
  };
}
