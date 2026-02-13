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
  };

  outputs = { self, nixpkgs, nix-darwin, nix-homebrew, home-manager }:
    let
      system = "x86_64-linux";
      username = "avien";

      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };

    in
    {
      nixosConfigurations = {
        barioth = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit username;
          };

          modules = [ ./hosts/barioth ];
        };

        bazelgeuse = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit username;
          };

          modules = [
            ./hosts/bazelgeuse

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.${username} = {
                imports = [
                  ./modules/home
                ];
              };
            }
          ];
        };

        magnamalo = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit username;
          };

          modules = [
            ./hosts/magnamalo

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.${username} = {
                imports = [
                  ./modules/home
                ];
              };
            }
          ];
        };

        rathian = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit username;
          };

          modules = [ ./hosts/rathian ];
        };

        zinogre = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit username;
          };

          modules = [ ./hosts/zinogre ];
        };
      };

      darwinConfigurations = {
        rathalos = nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit username self;
          };

          modules = [
            ./hosts/rathalos

            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                enableRosetta = true;
                user = username;
                autoMigrate = true;
              };
            }
          ];
        };

        magala = nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit username self;
          };

          modules = [
            ./hosts/magala

            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                user = username;
                autoMigrate = true;
              };
            }
          ];
        };
      };
    };
}
