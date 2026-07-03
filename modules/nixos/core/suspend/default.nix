{ config, lib, ... }:

{
  config = lib.mkIf (config.host.class == "laptop") {
    services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchDocked = "ignore";
      HandleLidSwitchExternalPower = "ignore";
    };
  };
}
