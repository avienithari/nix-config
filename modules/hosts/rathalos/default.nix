{ ... }:

{
  host.class = "desktop";

  nixpkgs.hostPlatform = "aarch64-darwin";

  nix-homebrew.enableRosetta = true;

  system.stateVersion = 6;
}
