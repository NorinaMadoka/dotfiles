{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.myOptions.mako;
in
{
  options.myOptions.mako = {
    enable = mkEnableOption "mako service" // {
      default = config.myOptions.vars.withGui;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.myOptions.vars.username} = {
      home.packages = [ pkgs.libnotify ];
      services.mako = {
        enable = true;

        anchor = "top-right";
        borderRadius = 5;
        borderSize = 2;
        padding = "20";
        defaultTimeout = 5000;
        layer = "top";
        height = 100;
        width = 300;
        format = "<b>%s</b>\\n%b";

        extraConfig = ''
          [urgency=low]
          default-timeout=3000

          [urgency=high]
          default-timeout=10000

          [mode=dnd]
          invisible=1
        '';
      };
    }; # For Home-Manager options
  };
}
