{ config, pkgs, ... }: {
  gtk = {
    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };
    enable = true;
    font = {
      name = "Monospace";
      size = 10;
    };
    theme = {
      package = pkgs.mojave-gtk-theme;
      name = "Mojave-Dark-alt";
    };
    cursorTheme = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors-white";
      size = 24;
    };
    iconTheme = {
      package = pkgs.whitesur-icon-theme;
      name = "WhiteSur";
    };
  };
}
