{ pkgs, lib, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = lib.mkForce {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };
  };
}
