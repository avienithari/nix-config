{
  description = "Rathalos nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
    let
      configuration = { pkgs, ... }: {
        nixpkgs.config.allowUnfree = true;
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
            pkgs.gimp
            pkgs.gnupg
            pkgs.gnutls
            pkgs.httrack
            pkgs.inkscape
            pkgs.jq
            pkgs.keycastr
            pkgs.lazygit
            pkgs.luajit
            pkgs.luajitPackages.jsregexp
            pkgs.neovim
            pkgs.ninja
            pkgs.nixpkgs-fmt
            pkgs.nodejs_23
            pkgs.php
            pkgs.ripgrep
            pkgs.speedtest-cli
            pkgs.spotify
            pkgs.stow
            pkgs.tldr
            pkgs.tmux
            pkgs.tokei
            pkgs.tree
            pkgs.virtualenv
            pkgs.wget
            pkgs.yt-dlp
          ];

        homebrew = {
          enable = true;
          brews = [
            "lld"
            "llvm"
            "lua"
            "luarocks"
            "mas"
            "pyvim"
            "zsh-autosuggestions"
            "zsh-syntax-highlighting"
          ];
          casks = [
            "discord"
            "ghostty"
            "monitorcontrol"
            "vlc"
          ];
          masApps = {
            "Elmedia Video Player" = 1044549675;
          };
          onActivation.cleanup = "zap";
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
        };

        system.defaults = {
          NSGlobalDomain.KeyRepeat = 2;
        };

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
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "avien";
              autoMigrate = true;
            };
          }
        ];
      };

      darwinPackages = self.darwinConfigurations."rathalos".pkgs;
    };
}
