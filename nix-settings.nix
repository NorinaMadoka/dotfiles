{
  inputs,
  system,
  nixpkgs,
  max-jobs,
}:
# Nix daemon settings that can't be put in `nixConfig`.
{
  extraOptions = ''
    keep-outputs = true
    keep-derivations = true
    http-connections = 0
  '';

  nixPath = [
    "nixpkgs=${nixpkgs}"
    "home-manager=${inputs.home}"
  ];

  package = inputs.nix.packages.${system}.default;

  gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };

  optimise.automatic = true;

  registry = {
    system.flake = inputs.self;
    default.flake = nixpkgs;
    nixpkgs.flake = nixpkgs;
    home-manager.flake = inputs.home;
  };

  settings = let
    isDarwin = nixpkgs.lib.hasSuffix "darwin" system;
  in {
    accept-flake-config = true;
    experimental-features = ["ca-derivations" "flakes" "nix-command"];
    inherit max-jobs;

    auto-optimise-store = true;

    sandbox = !isDarwin;
    sandbox-fallback = nixpkgs.lib.mkForce isDarwin;

    # home-manager will attempt to rebuild the world otherwise...
    substituters = [
      "https://cache.nixos.org?priority=7"
      "https://cache.garnix.io?priority=6"
      "https://nix-community.cachix.org?priority=5"
      "https://ezkea.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://hyprland.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];

    trusted-users = ["root" "@wheel"];
    allowed-users = ["@wheel"];
  };
}
