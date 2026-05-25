{ self, lib, inputs, username, ... }:

{
  imports = [
    ./common-packages.nix
    ./homebrew.nix
    ./lld.nix
    ./steam.nix

    ./options.nix
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

    system = {
      configurationRevision = self.rev or self.dirtyRev or null;

      defaults = {
        NSGlobalDomain.KeyRepeat = 2;
      };
    };

    programs.zsh.enable = true;
  };
}
