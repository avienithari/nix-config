{ lib, inputs, username, ... }:

{
  imports = [
    ./common-packages.nix
    ./homebrew.nix
    ./lld.nix
    ./settings.nix
    ./steam.nix

    ./maintenance
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  config = {
    nix-homebrew = {
      enable = true;
      enableRosetta = lib.mkDefault false;
      user = username;
      autoMigrate = true;
    };
  };
}
