{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    bash-language-server
    bat
    bc
    brave
    brotli
    btop
    fastfetch
    fd
    ffmpeg-full
    ffmpeg-headless
    ffmpegthumbnailer
    fzf
    gnupg
    luajit
    luajitPackages.jsregexp
    neovim
    nixd
    nixpkgs-fmt
    nodejs_24
    pylint
    pyright
    python314
    ripgrep
    slack
    spotify
    stow
    stylua
    tldr
    tmux
    tree
    tree-sitter
    wget
    yazi
    yt-dlp
  ];
}
