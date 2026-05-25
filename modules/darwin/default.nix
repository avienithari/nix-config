{ config, self, lib, inputs, username, ... }:

let
  cfg = config.host.feature.useHome;
in
{
  imports = [
    ./options.nix
    ./homebrew
    ./maintenance
    ./packages
    inputs.nix-homebrew.darwinModules.nix-homebrew
    inputs.home-manager.darwinModules.home-manager
  ];

  config = lib.mkMerge [
    {
      nix-homebrew = {
        enable = true;
        user = username;
        autoMigrate = true;
        enableRosetta = lib.mkDefault false;
      };

      system = {
        configurationRevision = self.rev or self.dirtyRev or null;

        defaults = {
          NSGlobalDomain.KeyRepeat = 2;
        };
      };

      users.users.${username}.home = "/Users/${username}";
    }

    (lib.mkIf cfg {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit username;
        };

        users.${username}.imports = [ ./home ];
      };
    })
  ];
}
