{ pkgs, self, username, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    android-tools
    argparse
    bash
    bat
    brave
    brotli
    btop
    calcure
    clisp
    cmake
    fastfetch
    fd
    ffmpeg-full
    ffmpeg-headless
    ffmpegthumbnailer
    fzf
    gd
    gimp
    gh
    gnupg
    gnutls
    go
    httrack
    inkscape
    jq
    keycastr
    luajit
    luajitPackages.jsregexp
    neovim
    ninja
    nixpkgs-fmt
    nodejs_24
    php
    ripgrep
    slack
    speedtest-cli
    spotify
    stow
    tldr
    tmux
    tokei
    tree
    virtualenv
    wget
    yazi
    yt-dlp
    zig
  ];
}
