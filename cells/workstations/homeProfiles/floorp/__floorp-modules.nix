{ lib, ... }:

with lib;

let

  modulePath = [
    "programs"
    "floorp"
  ];

  mkFirefoxModule = import ./__mkFirefoxModule.nix;

in
{
  meta.maintainers = [ hm.maintainers.bricked ];

  imports = [
    (mkFirefoxModule {
      inherit modulePath;
      name = "Floorp";
      wrappedPackageName = "floorp";
      unwrappedPackageName = "floorp-unwrapped";
      visible = true;

      platforms.linux = {
        configPath = ".floorp";
      };
      platforms.darwin = {
        configPath = "Library/Application Support/Floorp";
      };
    })
  ];
}
