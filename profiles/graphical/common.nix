{
  pkgs,
  config,
  ...
}: {
  home-manager.users.${config.vars.username} = {
    home.packages = with pkgs; [
      authy
      (discord-canary.override {
        nss = pkgs.nss_latest;
        withOpenASAR = true;
        withTTS = true;
      })
      webcord
      tdesktop
      mpv
      viewnior
    ];
  };
}
