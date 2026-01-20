{ pkgs, ... }:

let
  tooling = with pkgs; [
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
  environment.systemPackages = with pkgs; [
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
  ] ++ tooling;
}
