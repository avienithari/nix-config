{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";

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
            username = "avien";
          };

          modules = [
            ./nixos/configuration.nix
            ./modules/adb.nix
            ./modules/avien.nix
            ./modules/common-packages.nix
            ./modules/desktop-packages.nix
            ./modules/dev-packages.nix
            ./modules/gnupg.nix
            ./modules/hyprland.nix
            ./modules/keyd.nix
            ./modules/ssh.nix
            ./modules/syncthing.nix
            ./modules/tailscale.nix

            { networking.hostName = nixpkgs.lib.mkForce "magnamalo"; }
            { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }
          ];
        };
      };
    };
}
