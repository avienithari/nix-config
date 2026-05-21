{ lib, username, secrets, ... }:

let
  private = import "${secrets}/private.nix";
in
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = lib.mkDefault false;
      PermitRootLogin = "no";
      AllowUsers = [ "${username}" ];
      MaxAuthTries = 3;
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  users.users.${username}.openssh.authorizedKeys.keys =
    private.users.${username}.sshKeys;
}
