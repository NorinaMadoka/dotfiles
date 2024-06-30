{ inputs, cell }:
let
  inherit (cell) homeProfiles;
in
with homeProfiles;
rec {
  base = [
    common
    direnv
    gpg
    git
    ssh
    fish
  ];

  commonGraphic = [
    firefox
    mako

    # Etc
    discord
    spotify
    gammastep
  ];

  editor = [
    emacs
    nvim
  ];

  graphical =
    base
    ++ commonGraphic
    ++ editor
    ++ [
      theme

      # Windows Manager / Compositor
      hyprland
      sway
      waybar
      i3status-rust
      i3status
      fuzzel
      foot
      kitty
      # wezterm
      tmux
    ];

  airi = graphical;
}
