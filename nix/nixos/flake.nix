{
  description = "avien.nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
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
        magnamalo = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit username;
          };

          modules = [ ./hosts/magnamalo ];
        };

        rathian = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit username;
          };

          modules = [ ./hosts/rathian ];
        };
      };
    };
}
