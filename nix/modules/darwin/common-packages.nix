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
    gnupg
    gnutls
    go
    httrack
    inkscape
    jq
    keycastr
    lazygit
    luajit
    luajitPackages.jsregexp
    neovim
    ninja
    nixpkgs-fmt
    nodejs_23
    php
    ripgrep
    speedtest-cli
    spotify
    stow
    tldr
    tmux
    tokei
    tree
    virtualenv
    wget
    yt-dlp
    zig
  ];
}
