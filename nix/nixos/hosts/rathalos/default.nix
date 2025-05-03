{ pkgs, self, username, ... }:

{
  imports = [
    ../../modules/darwin/common-packages.nix
    ../../modules/darwin/homebrew.nix
    ../../modules/darwin/lld.nix
    ../../modules/darwin/settings.nix
    ../../modules/darwin/steam.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
}
