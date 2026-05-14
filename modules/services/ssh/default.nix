{ lib, username, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = lib.mkDefault false;
      PermitRootLogin = "no";
      AllowUsers = [ "${username}" ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
}
