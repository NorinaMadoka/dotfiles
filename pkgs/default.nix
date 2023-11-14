{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      geist-font = pkgs.callPackage ./geist-font {};

      multicolor-sddm-theme = pkgs.callPackage ./multicolor-sddm-theme {};

      iosevka-q = pkgs.callPackage ./iosevka-q {};

      san-francisco-pro = pkgs.callPackage ./san-francisco-pro {};

      spotify = pkgs.callPackage ./spotify {};

      vesktop = pkgs.callPackage ./vesktop {};

      wavefox = pkgs.callPackage ./wavefox {};

      webcord-vencord = pkgs.callPackage ./webcord-vencord {};

      wezterm = pkgs.darwin.apple_sdk_11_0.callPackage ./wezterm {
        inherit (pkgs.darwin.apple_sdk_11_0.frameworks) Cocoa CoreGraphics Foundation UserNotifications System;
      };
    };
  };
}
