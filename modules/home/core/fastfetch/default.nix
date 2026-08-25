{ lib, ... }:

let
  nixDarkBlue = "#5277C3";
  nixLightBlue = "#7EBAE4";

  logo = {
    type = "builtin";
    source = "nixos";
    color = builtins.listToAttrs (
      builtins.genList
        (i: {
          name = toString (i + 1);
          value = if lib.mod i 2 == 0 then nixDarkBlue else nixLightBlue;
        }) 6
    );
  };

  ageModule = {
    type = "command";
    key = "Age";
    keyColor = "36";
    text = ''
      birth=$(stat -c %W / 2>/dev/null)
      if [ -z "$birth" ] || [ "$birth" -eq 0 ]; then
        birth=$(stat -c %Y /)
      fi

      echo "$((($(date +%s) - birth) / 86400)) days"
    '';
  };
in
{
  programs.fastfetch = {
    enable = true;
    settings = {
      inherit logo;
      modules = [
        "title"
        "separator"
        "os"
        ageModule
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "locale"
        "break"
        "colors"
        "break"
      ];
    };
  };
}
