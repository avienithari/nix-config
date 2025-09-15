{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      ubuntu_font_family
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        serif = [ "Ubuntu Regular" ];
        sansSerif = [ "Ubuntu Regular" ];
        monospace = [ "Ubuntu Mono Regular" ];
      };
    };
  };
}
