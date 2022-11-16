{ inputs, pkgs, config, lib, ... }:

{
  home.packages = with pkgs; [
    hyprpaper # For Wallpaper
    mako # Notification
    bemenu # Menu 
    wofi # Menu
    waybar # Bar

    # Terminal
    kitty
    foot

    # Utils
    grim
    slurp
    wl-clipboard
    brightnessctl
    playerctl
    yad
    viewnior
    xdg-user-dirs
    xdg-utils
    #hyprland (using flakes version)
  ];
  home.file = {
    hyprland = {
      source = ../hyprland;
      target = ".config/hypr";
      recursive = true;
    };
  };
}
