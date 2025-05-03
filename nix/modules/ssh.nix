{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.avien.ssh;
in
{
  options.avien.ssh = {
    passwordAuthentication = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = cfg.passwordAuthentication;
        PermitRootLogin = "no";
      };
    };

    networking.firewall.allowedTCPPorts = [ 22 ];
  };
}
