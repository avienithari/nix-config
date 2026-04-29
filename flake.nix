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

  outputs =
    { self, nixpkgs, nix-darwin, nix-homebrew, home-manager, agenix, secrets }:
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
        arzuros = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit username;
            inherit agenix;
            inherit secrets;
          };

          modules = [
            ./modules/hosts/arzuros

            agenix.nixosModules.default

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                vars = {
                  class = "laptop";
                };
              };

              home-manager.users.${username} = {
                imports = [
                  ./modules/home
                ];
              };
            }
          ];
        };

        barioth = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit username;
            inherit agenix;
            inherit secrets;
          };

          modules = [
            ./modules/hosts/barioth

            agenix.nixosModules.default
          ];
        };

        bazelgeuse = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit username;
            inherit agenix;
            inherit secrets;
          };

          modules = [
            ./modules/hosts/bazelgeuse

            agenix.nixosModules.default

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                vars = {
                  class = "desktop";
                };
              };

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
            inherit agenix;
            inherit secrets;
          };

          modules = [
            ./modules/hosts/magnamalo

            agenix.nixosModules.default

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                vars = {
                  class = "laptop";
                };
              };

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
            inherit agenix;
            inherit secrets;
          };

          modules = [
            ./modules/hosts/rathian

            agenix.nixosModules.default

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                vars = {
                  class = "server";
                };
              };

              home-manager.users.${username} = {
                imports = [
                  ./modules/home
                ];
              };
            }
          ];
        };

        zinogre = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit username;
            inherit agenix;
            inherit secrets;
          };

          modules = [
            ./modules/hosts/zinogre

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                vars = {
                  class = "desktop";
                };
              };

              home-manager.users.${username} = {
                imports = [
                  ./modules/home
                ];
              };
            }

            agenix.nixosModules.default
          ];
        };
      };

      darwinConfigurations = {
        rathalos = nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit username self;
          };

          modules = [
            ./modules/hosts/rathalos

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
            ./modules/hosts/magala

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
