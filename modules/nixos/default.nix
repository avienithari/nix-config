{ config, lib, inputs, username, ... }:

{
  imports = [
    ./options.nix
    ./core
    ./gui
    ./misc
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
  ];

  config = lib.mkMerge [
    {
      _module.args = {
        agenix = inputs.agenix;
        secrets = inputs.secrets;
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
