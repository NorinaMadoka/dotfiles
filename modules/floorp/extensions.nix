{ inputs, pkgs, ... }:
{
  force = true;
  packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
    bitwarden
    refined-github
    sponsorblock
    to-deepl
    ublock-origin
  ];
  settings = {
    "uBlock0@raymondhill.net" = {
      force = true;
      settings = {
        advancedUserEnabled = true;
        selectedFilterLists = [
          "user-filters"
          "ublock-filters"
          "ublock-badware"
          "ublock-privacy"
          "ublock-unbreak"
          "ublock-quick-fixes"
          "easylist"
          "easyprivacy"
          "urlhaus-1"
          "plowe-0"
          "adguard-spyware-url"
          "fanboy-cookiemonster"
          "ublock-cookies-easylist"
          "easylist-annoyances"
          "easylist-chat"
          "easylist-newsletters"
          "easylist-notifications"
          "ublock-annoyances"
          "IDN-0"
        ];
      };
    };
  };
}
