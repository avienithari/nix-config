{ lib, secrets, ... }:

let
  private = import "${secrets}/private.nix";
  dnsAddress = private.services.dnsAddress;
in
{
  networking = {
    nameservers = lib.mkDefault [ dnsAddress ];
    networkmanager.insertNameservers = lib.mkDefault [ dnsAddress ];
  };
}
