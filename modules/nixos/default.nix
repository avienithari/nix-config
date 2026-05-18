{ config, lib, inputs, username, ... }:

{
  imports = [
    ./options.nix
    ./core
    ./gui
    ./misc
    ../services
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
  ];

  config = lib.mkMerge [
    {
      _module.args = {
        inherit (inputs) agenix secrets;
      };
    }

    (lib.mkIf config.host.feature.useHome {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${username}.imports = [ ../home ];
      };
    })
  ];
}
