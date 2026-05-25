{ username, ... }:

{
  host.feature = {
    lld = true;
    steam = true;
    useHome = true;
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  nix-homebrew.enableRosetta = true;

  system.primaryUser = username;

  system.stateVersion = 6;
}
