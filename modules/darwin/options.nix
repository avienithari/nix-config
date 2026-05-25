{ lib, ... }:

{
  options.host = {
    feature = {
      lld = lib.mkEnableOption "Enable lld";
      steam = lib.mkEnableOption "Enable steam";
    };
  };
}
