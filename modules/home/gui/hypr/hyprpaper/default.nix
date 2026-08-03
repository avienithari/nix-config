{ ... }:

let
  leavesWallpaper = ../assets/leaves.jpg;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = "${leavesWallpaper}";
        }
      ];
    };
  };
}
