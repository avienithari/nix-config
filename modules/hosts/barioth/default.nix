{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../services
    ../../nixos
  ];

  host = {
    isGuiHost = true;
    desktop = "hyprland";
    feature.steam = true;
  };

  networking.hostName = lib.mkForce "barioth";

  avien.ssh.passwordAuthentication = true;
}
