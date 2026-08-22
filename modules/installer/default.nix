{ lib, inputs, pkgs, modulesPath, username, ... }:

let
  private = import "${inputs.secrets}/private.nix";
in
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../users/avien
  ];

  security.sudo.wheelNeedsPassword = false;

  boot.zfs.forceImportRoot = false;

  nixpkgs.hostPlatform = "x86_64-linux";

  environment.systemPackages = with pkgs; [
    git
    tmux
    vim
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        LoginGraceTime = 0;
        AllowUsers = [ "${username}" ];
        MaxAuthTries = 3;
      };
    };

    getty = {
      helpLine = lib.mkForce "";
      greetingLine = lib.mkForce "";
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  users.users.${username}.openssh.authorizedKeys.keys =
    private.users.${username}.sshKeys;
}
