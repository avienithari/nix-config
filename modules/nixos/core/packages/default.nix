{ agenix, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
    bash-language-server
    bat
    bc
    btop
    fastfetch
    fd
    fzf
    ghostty
    git
    lua-language-server
    lua5_1
    luajitPackages.jsregexp
    luarocks
    ncdu
    neovim
    nixd
    nixpkgs-fmt
    nodejs_24
    pylint
    pyright
    python314
    ripgrep
    stow
    stylua
    tldr
    tmux
    tree
    tree-sitter
    unzip
    wget
  ];
}
