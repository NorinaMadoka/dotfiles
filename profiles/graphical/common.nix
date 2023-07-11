{
  pkgs,
  config,
  lib,
  ...
}: let
  # use OCR and copy to clipboard
  ocrScript = let
    inherit (pkgs) grim libnotify slurp tesseract5 wl-clipboard;
    _ = lib.getExe;
  in
    pkgs.writeShellScriptBin "wl-ocr" ''
      ${_ grim} -g "$(${_ slurp})" -t ppm - | ${_ tesseract5} - - | ${wl-clipboard}/bin/wl-copy
      ${_ libnotify} "$(${wl-clipboard}/bin/wl-paste)"
    '';
  sharenix = pkgs.writeShellScriptBin "sharenix" ''${builtins.readFile ./scripts/screenshot}'';
in {
  security = {
    # pam.services.greetd.gnupg.enable = true;
    # pam.services.greetd.enableGnomeKeyring = true;
    pam.services.swaylock.text = "auth include login";
  };
  home-manager.users.${config.vars.username} = {
    home.packages = with pkgs; [
      authy
      (discord-canary.override {
        nss = pkgs.nss_latest;
        withOpenASAR = true;
        withTTS = true;
        withVencord = true;
      })
      webcord-vencord
      tdesktop
      mpv
      mailspring
      viewnior
      whatsapp-for-linux

      # Utils
      ocrScript
      sharenix
    ];
  };
}
