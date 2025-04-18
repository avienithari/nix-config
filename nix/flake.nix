{
  description = "Rathalos nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
            pkgs.android-tools
            pkgs.argparse
            pkgs.bash
            pkgs.bat
            pkgs.brave
            pkgs.brotli
            pkgs.btop
            pkgs.clisp
            pkgs.cmake
            pkgs.fastfetch
            pkgs.fd
            pkgs.ffmpeg-full
            pkgs.ffmpeg-headless
            pkgs.ffmpegthumbnailer
            pkgs.fzf
            pkgs.gd
            pkgs.inkscape
            pkgs.jq
            pkgs.keycastr
            pkgs.lazygit
            pkgs.luajit
            pkgs.neovim
            pkgs.ninja
            pkgs.php
            pkgs.ripgrep
            pkgs.speedtest-cli
            pkgs.stow
            pkgs.tldr
            pkgs.tmux
            pkgs.tokei
            pkgs.tree
            pkgs.virtualenv
            pkgs.wget
            pkgs.yt-dlp
        ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#rathalos
    darwinConfigurations."rathalos" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    darwinPackages = self.darwinConfigurations."rathalos".pkgs;
  };
}
