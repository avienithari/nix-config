{ username, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix-homebrew.enableRosetta = true;

  system.primaryUser = username;

  system.stateVersion = 6;
}
