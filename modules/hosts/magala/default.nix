{ ... }:

{
  imports = [
    ../../darwin/common-packages.nix
    ../../darwin/homebrew.nix
    ../../darwin/settings.nix
  ];

  nixpkgs.hostPlatform = "x86_64-darwin";
}
