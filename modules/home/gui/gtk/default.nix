{ pkgs, pkgs-stable, lib, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    # TODOS: fix me
    theme = lib.mkForce {
      name = "rose-pine";
      package = pkgs-stable.rose-pine-gtk-theme;
    };
  };
}
