{ pkgs, self, username, ... }:

{
  imports = [
    ../../modules/darwin/common-packages.nix
    ../../modules/darwin/homebrew.nix
    ../../modules/darwin/settings.nix
  ];

  nixpkgs.hostPlatform = "x86_64-darwin";
}
