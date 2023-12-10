{username, ...}: {
  home = {
    inherit username;
    homeDirectory = "/home/airi";

    stateVersion = "23.11";
  };

  mine = {
    direnv.enable = true;
    fuzzel.enable = true;
    kitty.enable = true;
    hyprland.enable = true;
    mako.enable = true;
    gammastep.enable = true;
    git.enable = true;
    gpg.enable = true;
    waybar.enable = true;
    zsh.enable = true;
  };
}
