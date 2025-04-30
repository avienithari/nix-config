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
          specialArgs = { inherit system; };

          modules = [
            ./nixos/configuration.nix

            {
              environment.systemPackages = with pkgs; [
                gnupg
                pinentry-curses

                acpi

                _1password-gui-beta
                brave
                btop
                fastfetch
                gh
                ghostty
                git
                neovim
                nixpkgs-fmt
                stow
                tailscale
                tldr
                tmux
                tree

                fzf
                gcc
                go
                nodejs_23
                python314
                rustup
                unzip
                zig

                keyd
                hyprland
                waybar
                wofi

                (waybar.overrideAttrs (oldAttrs: {
                  mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
                }))
              ];
            }
            { networking.hostName = nixpkgs.lib.mkForce "magnamalo"; }
            {
              environment.variables = { XDG_SESSION_TYPE = "wayland"; };
              programs.hyprland.enable = true;

              xdg.portal.enable = true;
              xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

              security.rtkit.enable = true;
              services.pipewire = {
                enable = true;
                alsa.enable = true;
                alsa.support32Bit = true;
                pulse.enable = true;
                jack.enable = true;
              };
            }
            { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }
            {
              programs.gnupg.agent = {
                enable = true;
                pinentryPackage = pkgs.pinentry-curses;
              };
            }
            {
              services.openssh = {
                enable = true;
              };
            }
            {
              networking.firewall.allowedTCPPorts = [ 22 ];
            }
            {
              users.users.avien = {
                shell = pkgs.zsh;
                extraGroups = [ "audio" ];
              };
            }
            {
              programs.zsh.enable = true;
            }
            {
              services.keyd = {
                enable = true;
                keyboards = {
                  default = {
                    ids = [ "*" ];
                    settings = {
                      main = {
                        capslock = "esc";
                      };
                    };
                  };
                };
              };
            }
            {
              services.tailscale = {
                enable = true;
                useRoutingFeatures = "client";
              };
            }
          ];
        };
      };
    };
}
