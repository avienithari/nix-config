{ inputs, pkgs, modulesPath, username, ... }:

let
  private = import "${inputs.secrets}/private.nix";
  userKeys = private.users.${username}.sshKeys;
in
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    inputs.agenix.nixosModules.default
  ];

  boot.zfs.forceImportRoot = false;

  nixpkgs.hostPlatform = "x86_64-linux";

  environment.systemPackages = with pkgs; [
    git
    nh
    tmux
    vim
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.openssh = {
    enable = true;
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  users.users.root.openssh.authorizedKeys.keys = userKeys;
}
