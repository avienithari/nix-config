{ lib, ... }:

{
  options.host = {
    class = lib.mkOption {
      type = lib.types.str;
    };

    feature = {
      lld = lib.mkEnableOption "Enable lld";
      steam = lib.mkEnableOption "Enable steam";
      useHome = lib.mkEnableOption "Enable home-manager configuration";
    };
  };
}
