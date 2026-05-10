{ pkgs, username, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  programs.nh = {
    enable = true;
    package = pkgs.nh;
    flake = "/home/${username}/nix-config";
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 3";
    };
  };
}
