{ config, pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [
    bibata-cursors
    brightnessctl
    grim
    hypridle
    hyprland
    hyprlock
    hyprpaper
    playerctl
    slurp
    waybar
    wl-clipboard
    wofi

    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
  ];

  environment.variables = { XDG_SESSION_TYPE = "wayland"; };
  programs.hyprland.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  users.users.${username} = {
    extraGroups = [ "audio" ];
  };
}
