{
  description = "avien.nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "git+file:///home/avien/nix-secrets";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, ... }:
    let
      username = "avien";
      system = "x86_64-linux";

      nixosHosts = [
        "arzuros"
        "barioth"
        "bazelgeuse"
        "magnamalo"
        "rathian"
        "zinogre"
      ];

      darwinHosts = [
        "magala"
        "rathalos"
      ];
    in
    {
      nixosConfigurations = (nixpkgs.lib.genAttrs nixosHosts (host:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              inputs
              username
              system;
          };
          modules = [
            ./modules/nixos
            ./modules/hosts/${host}
          ];
        }
      )) // {
        iso = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              inputs
              username
              system;
          };
          modules = [
            ./modules/installer
          ];
        };
      };

      darwinConfigurations = nixpkgs.lib.genAttrs darwinHosts (host:
        nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit
              inputs
              username
              self;
          };
          modules = [
            ./modules/darwin
            ./modules/hosts/${host}
          ];
        }
      );

      devShells.${system}.default = import ./modules/shell.nix {
        inherit inputs system;
      };
    };
}
