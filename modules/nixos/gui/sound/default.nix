{ config, lib, username, ... }:

{
  config = lib.mkIf config.host.isGuiHost {
    security.rtkit.enable = true;

    services = {
      pulseaudio.enable = false;

      pipewire = {
        enable = true;

        alsa = {
          enable = true;
          support32Bit = true;
        };

        pulse.enable = true;
        jack.enable = true;
        wireplumber = {
          enable = true;

          extraConfig."51-reverse-speakers" =
            lib.mkIf (config.networking.hostName == "bazelgeuse") {
              "monitor.alsa.rules" = [
                {
                  matches = [
                    {
                      "node.name" =
                        "alsa_output.pci-0000_13_00.6.analog-stereo";
                    }
                  ];
                  actions = {
                    update-props = {
                      "audio.position" = [ "FR" "FL" ];
                    };
                  };
                }
              ];
            };
        };
      };
    };

    users.users.${username} = {
      extraGroups = [ "audio" ];
    };
  };
}
