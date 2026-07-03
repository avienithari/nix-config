{ config, lib, username, ... }:

{
  config = lib.mkIf config.host.isGuiHost {
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [ username ];
    };
  };
}
