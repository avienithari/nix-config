{ self, lib, inputs, username, ... }:

{
  imports = [
    ./options.nix
    ./homebrew
    ./maintenance
    ./packages
    ./settings
    inputs.nix-homebrew.darwinModules.nix-homebrew
    inputs.home-manager.darwinModules.home-manager
  ];

  config = {
    nix-homebrew = {
      enable = true;
      user = username;
      autoMigrate = true;
      enableRosetta = lib.mkDefault false;
    };

    system = {
      primaryUser = username;
      configurationRevision = self.rev or self.dirtyRev or null;
    };

    users.users.${username}.home = "/Users/${username}";

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit username;
      };

      users.${username}.imports = [ ./home ];
    };
  };
}
