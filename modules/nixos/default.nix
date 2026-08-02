{ config, pkgs, lib, inputs, username, ... }:

let
  pkgs-stable = import inputs.nixpkgs-stable {
    system = pkgs.stdenv.hostPlatform.system;
  };
in
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
        inherit pkgs-stable;
      };
    }

    (lib.mkIf config.host.feature.useHome {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit (inputs) secrets;
          inherit pkgs-stable username;
        };

        users.${username}.imports = [ ../home ];
      };
    })
  ];
}
