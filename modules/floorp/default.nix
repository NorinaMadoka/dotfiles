{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.myOptions.floorp;
in {
  options.myOptions.floorp = {
    enable = mkEnableOption "floorp";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.myOptions.vars.username} = {
      programs.floorp = {
        enable = true;

        nativeMessagingHosts = [
          pkgs.keepassxc
        ];

        profiles = {
          ludovico =
            {
              id = 0;
              isDefault = true;
              name = "Ludovico";
              extensions = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
                refined-github
                sponsorblock
                to-deepl
                ublock-origin
                keepassxc-browser
              ];
              bookmarks = import ./bookmarks.nix;
              search = import ./search.nix {inherit pkgs;};
              settings = import ./settings.nix;
            }
            // (
              let
                betterfox = pkgs.fetchFromGitHub {
                  owner = "yokoffing";
                  repo = "Betterfox";
                  rev = "131.0";
                  hash = "sha256-CxPZxo9G44lRocNngjfwTBHSqL5dEJ5MNO5Iauoxp2Y=";
                };
              in {
                extraConfig = ''
                  ${builtins.readFile "${betterfox}/Fastfox.js"}
                  ${builtins.readFile "${betterfox}/Peskyfox.js"}
                  ${builtins.readFile "${betterfox}/Securefox.js"}
                  ${builtins.readFile "${betterfox}/Smoothfox.js"}

                  /* Betterfox overrides */
                  // PREF: disable address and credit card manager
                  user_pref("extensions.formautofill.addresses.enabled", false);
                  user_pref("extensions.formautofill.creditCards.enabled", false);

                  // PREF: enable HTTPS-Only Mode
                  // Warn me before loading sites that don't support HTTPS
                  // when using Private Browsing windows.
                  user_pref("dom.security.https_only_mode_pbm", true);
                  user_pref("dom.security.https_only_mode_error_page_user_suggestions", true);

                  // PREF: disable Firefox Sync
                  user_pref("identity.fxaccounts.enabled", false);

                  // PREF: disable the Firefox View tour from popping up
                  user_pref("browser.firefox-view.feature-tour", "{\"screen\":\"\",\"complete\":true}");

                  /* Custom User.js */
                  user_pref("browser.tabs.firefox-view-next", false);
                  user_pref("privacy.sanitize.sanitizeOnShutdown", false);
                  user_pref("privacy.clearOnShutdown.cache", false);
                  user_pref("privacy.clearOnShutdown.cookies", false);
                  user_pref("privacy.clearOnShutdown.offlineApps", false);
                  user_pref("browser.sessionstore.privacy_level", 0);
                '';
              }
            );
        };
      };
    };
  };
}
