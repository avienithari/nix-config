{ pkgs, username, ... }:

{
  nix.settings.experimental-features = "nix-command flakes";

  environment = {
    systemPackages = [ pkgs.nh ];
    variables.NH_FLAKE = "/Users/${username}/nix-config";
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
    interval = {
      Hour = 10;
      Minute = 0;
    };
  };
}
