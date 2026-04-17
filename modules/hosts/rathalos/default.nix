{ username, ... }:

{
  imports = [
    ../../darwin/common-packages.nix
    ../../darwin/homebrew.nix
    ../../darwin/lld.nix
    ../../darwin/settings.nix
    ../../darwin/steam.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  system.primaryUser = username;
}
