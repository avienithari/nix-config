{ config, lib, ... }:

{
  config = lib.mkIf (config.host.class != "server") {
    services = {
      printing.enable = true;

      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
  };
}
