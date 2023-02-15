# This Config is Heavily Based on the Config of sioodmy
# https://github.com/sioodmy/dotfiles
# And ocrScript is from fufexan's dotfiles
{
  lib,
  pkgs,
  config,
  inputs,
  ...
} @ args: let
  inherit (config.vars.colorScheme) colors;
  mkService = lib.recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
  # use OCR and copy to clipboard
  ocrScript = let
    inherit (pkgs) grim libnotify slurp tesseract5 wl-clipboard;
    _ = lib.getExe;
  in
    pkgs.writeShellScriptBin "wl-ocr" ''
      ${_ grim} -g "$(${_ slurp})" -t ppm - | ${_ tesseract5} - - | ${wl-clipboard}/bin/wl-copy
      ${_ libnotify} "$(${wl-clipboard}/bin/wl-paste)"
    '';
  powermenu-launch = pkgs.writeShellScriptBin "powermenu-launch" ''${builtins.readFile ./scripts/powermenu}'';
  sharenix = pkgs.writeShellScriptBin "sharenix" ''${builtins.readFile ./scripts/screenshot}'';
in {
  systemd.services = {
    seatd = {
      enable = true;
      description = "Seat Management Daemon";
      script = "${pkgs.seatd}/bin/seatd -g wheel";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = 1;
      };
      wantedBy = ["multi-user.target"];
    };
  };

  home-manager.users."${config.vars.username}" = {
    home.packages = with pkgs; [
      # Utils
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
      fuzzel
      grim
      slurp
      ocrScript
      sharenix
      powermenu-launch
    ];

    #TODO: Move this somewhere else
    xdg.configFile."fuzzel/fuzzel.ini".text = ''
      font='Iosevka Nerd Font-16'
      icon-theme='WhiteSur'
      prompt='->'
      [dmenu]
      mode=text
      [colors]
      background=24283bff
      text=a9b1d6ff
      match=8031caff
      selection=8031caff
      selection-text=7aa2f7ff
      selection-match=2ac3deff
      border=8031caff

      [border]
      width=2
      radius=0
    '';

    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.default;
      systemdIntegration = true;
      extraConfig = import ./config.nix args;
    };

    programs.fish.interactiveShellInit = lib.mkBefore ''
      if test -z $DISPLAY && test (tty) = "/dev/tty1"
          exec Hyprland
      end
    '';

    # User Services
    systemd.user.services = {
      #   swaybg = mkService {
      #     Unit.Description = "Images Wallpaper Daemon";
      #     Service = {
      #       ExecStart = "${lib.getExe pkgs.swaybg} -i ${./Wallpaper/wallpaper.jpg}";
      #       Restart = "always";
      #     };
      #   };
      # mpvpaper = mkService {
      #   Unit.Description = "Video Wallpaper Daemon";
      #   Service = {
      #     ExecStart = "${lib.getExe pkgs.mpvpaper} -o \"no-audio --loop-playlist shuffle\" eDP-1 ${./Wallpaper/wallpaper.mp4}";
      #     Restart = "always";
      #   };
      # };
      cliphist = mkService {
        Unit.Description = "Clipboard History";
        Service = {
          ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${lib.getExe pkgs.cliphist} store";
          Restart = "always";
        };
      };
    };
  };
}
