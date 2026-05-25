{ ... }:

{
  host = {
    class = "desktop";
    feature = {
      lld = true;
      steam = true;
      useHome = true;
    };
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  nix-homebrew.enableRosetta = true;

  system.stateVersion = 6;
}
