{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mine.gpg;
  inherit (lib) mkIf mkOption types;
in
{
  options.mine.gpg = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Enable gpg and set configuration.
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.gpg = {
      enable = true;
      homedir = "${config.xdg.configHome}/gnupg";
    };

    # Fix pass
    services.gpg-agent = {
      enable = true;
      /*
        Make sure to add this
        services.dbus.packages = [ pkgs.gcr ];
      */
      pinentryPackage = pkgs.pinentry-gnome3;
      extraConfig = ''
        allow-emacs-pinentry
        allow-loopback-pinentry
        allow-preset-passphrase
      '';
    };
  };
}
