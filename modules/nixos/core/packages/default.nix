{ agenix, pkgs, ... }:

# TODOS: i hate this
let
  oldCommonPkgs = with pkgs; [
    bat
    bc
    btop
    fastfetch
    fd
    ghostty
    git
    ncdu
    nixpkgs-fmt
    speedtest-cli
    stow
    tldr
    tmux
    tokei
    tree
    wget
  ];
  oldDevPkgs = with pkgs; [
    argparse
    clisp
    cmake
    jq
    lua
    luajit
    luajitPackages.jsregexp
    luarocks
    ninja
    php
  ];
  oldNvimPkgs = with pkgs; [
    fzf
    gcc
    go
    lua5_1
    neovim
    nixd
    nodejs_24
    python314
    ripgrep
    rustup
    tree-sitter
    unzip
    zig
  ];
  oldNvimToolingPkgs = with pkgs; [
    bash-language-server
    clang-analyzer
    docker-language-server
    gofumpt
    goimports-reviser
    golangci-lint-langserver
    gopls
    htmlhint
    htmx-lsp2
    lua-language-server
    pylint
    pyright
    rust-analyzer
    stylua
    vim-language-server
    zls
  ];
in
{
  environment.systemPackages = [
    agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ]
  ++ oldCommonPkgs
  ++ oldDevPkgs
  ++ oldNvimPkgs
  ++ oldNvimToolingPkgs;
}
