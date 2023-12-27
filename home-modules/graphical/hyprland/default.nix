{
  config,
  lib,
  pkgs,
  ...
}@args:
let
  cfg = config.mine.hyprland;
  inherit (lib) mkIf mkOption types;
in
{
  options.mine.hyprland = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable hyprland and set configuration.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      [
        # Utils
        pkgs.grimblast
      ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      settings = import ./settings.nix args;
    };
  };
}
