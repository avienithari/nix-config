{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    android-tools
    bat
    brave
    brotli
    btop
    fastfetch
    fd
    ffmpeg-full
    ffmpeg-headless
    ffmpegthumbnailer
    fzf
    gd
    gnupg
    luajit
    luajitPackages.jsregexp
    neovim
    nixpkgs-fmt
    nodejs_24
    ripgrep
    slack
    spotify
    stow
    tldr
    tmux
    tree
    tree-sitter
    wget
    yazi
    yt-dlp
  ];
}
