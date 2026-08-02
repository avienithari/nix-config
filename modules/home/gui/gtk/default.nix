{ pkgs, lib, inputs, ... }:

let
  pkgs-stable = import inputs.nixpkgs-stable {
    system = pkgs.stdenv.hostPlatform.system;
  };
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
      package = pkgs-stable.rose-pine-gtk-theme;
    };
  };
}
