{ lib, secrets, ... }:

let
  private = import "${secrets}/private.nix";
  dns = private.services.dns.ip;
in
{
  networking = {
    nameservers = lib.mkDefault [ dns ];
    networkmanager.insertNameservers = lib.mkDefault [ dns ];
  };
}
