{ lib, ... }:

{
  options.host = {
    class = lib.mkOption {
      type = lib.types.str;
    };
  };
}
