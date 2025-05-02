{ config, lib, ... }:

{
  networking.hostName = lib.mkForce "magnamalo";
}
