{
  pkgs,
  lib,
  inputs,
  ...
}: let
  sharenix = pkgs.writeShellScriptBin "sharenix" ''${builtins.readFile ./scripts/sharenix}'';

  # use OCR and copy to clipboard
  ocrScript = let
    inherit (pkgs) grim libnotify slurp tesseract5 wl-clipboard;
    _ = lib.getExe;
  in
    pkgs.writeShellScriptBin "wl-ocr" ''
      ${_ grim} -g "$(${_ slurp})" -t ppm - | ${_ tesseract5} - - | ${wl-clipboard}/bin/wl-copy
      ${_ libnotify} "$(${wl-clipboard}/bin/wl-paste)"
    '';
in {
  colorScheme = {
    slug = "Skeet";
    name = "Skeet";
    author = "Ludovico";
    colors =
      inputs.nix-colors.colorSchemes.dracula.colors
      // {
        blue = "1e5799";
        pink = "f300ff";
        yellow = "e0ff00";
        gray = "595959";
        white = "000000";
      };
  };

  home = {
    sessionVariables = {
      # Colorific GCC.
      GCC_COLORS = "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01";

      # https://ayats.org/blog/channels-to-flakes/
      NIX_PATH = "nixpkgs=flake:nixpkgs$\{NIX_PATH:+:$NIX_PATH}";

      NIXOS_OZONE_WL = "0";
      EDITOR = "emacs";
      VISUAL = "nvim";
      PAGER = "less -R";
      TERM = "screen-256color";
      BROWSER = "firefox";
      XCURSOR_SIZE = "24";
      DIRENV_LOG_FORMAT = "";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    packages = with pkgs; [
      authy
      tdesktop
      mpv
      mailspring
      imv
      whatsapp-for-linux

      # Utils
      ocrScript
      sharenix
    ];
  };
}
