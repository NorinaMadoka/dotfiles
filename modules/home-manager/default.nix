# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  hyprland = import ./hyprland;
  fish = import ./fish.nix;
  gtk = import ./gtk.nix;

  # Apps
  foot = import ./apps/foot;
  kitty = import ./apps/kitty;
  mako = import ./apps/mako;
  dunst = import ./apps/dunst;
  waybar = import ./apps/waybar;
  wofi = import ./apps/wofi;
  spicetify = import ./apps/spicetify;
  eww = import ./apps/eww;
  obs = import ./apps/obs;

  # Development
  git = import ./development/git.nix;
  gpg = import ./development/gpg.nix;
  direnv = import ./development/direnv.nix;
  vscode = import ./development/vscode.nix;

  # Browser
  chromium = import ./browser/chromium.nix;
  firefox = import ./browser/firefox.nix;
}
