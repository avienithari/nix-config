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
        serif = [
          "Ubuntu Regular"
          "Noto Serif CJK JP"
          "Noto Serif CJK SC"
        ];
        sansSerif = [
          "Ubuntu Regular"
          "Noto Sans CJK JP"
          "Noto Sans CJK SC"
        ];
        monospace = [
          "Ubuntu Mono Regular"
          "Noto Sans Mono CJK JP"
        ];
      };
    };
  };
}
