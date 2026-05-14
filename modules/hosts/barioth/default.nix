{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
    ../../services
    ../../nixos
  ];

  host = {
    class = "desktop";
    session = "hyprland";
    feature = {
      steam = true;
      useHome = true;
    };
  };

  networking.hostName = lib.mkForce "barioth";

  avien.ssh.passwordAuthentication = true;
}
