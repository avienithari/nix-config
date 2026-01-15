{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      ubuntu-classic
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
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
