{ config, pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [
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

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  users.users.${username} = {
    extraGroups = [ "audio" ];
  };
}
