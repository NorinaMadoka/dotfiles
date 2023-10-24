{
  outputs = inputs @ {nixpkgs, ...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];

      imports = [
        ./hosts
        ./homes

        inputs.devshell.flakeModule
        inputs.nixos-flake.flakeModule
        inputs.treefmt-nix.flakeModule
      ];

      perSystem = {
        config,
        pkgs,
        system,
        inputs',
        ...
      }: {
        # This sets `pkgs` to a nixpkgs with allowUnfree option set.
        _module.args.pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        # configure devshell
        devShells.default = let
          devshell = import ./parts/devshell;
        in
          inputs'.devshell.legacyPackages.mkShell {
            inherit (devshell) env;
            name = "Devshell";
            commands = devshell.shellCommands;
            packages = with pkgs; [
              inputs'.sops-nix.packages.default
              config.treefmt.build.wrapper
              nil
              alejandra
              git
              statix
              deadnix
            ];
          };

        # configure treefmt
        treefmt = let
          treefmt = import ./parts/treefmt;
        in {
          inherit (treefmt) programs;
          projectRootFile = "flake.nix";
          settings.formatter = treefmt.settingsFormatter;
        };
      };
    };

  inputs = {
    # Main Thing
    master.url = "github:nixos/nixpkgs/master";
    stable.url = "github:nixos/nixpkgs/release-23.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixpkgs.follows = "master";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    # For Webcord
    arrpc = {
      url = "github:NotAShelf/arrpc-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-super = {
      url = "github:privatevoid-net/nix-super";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };

    base16-schemes.url = "github:tinted-theming/base16-schemes";
    base16-schemes.flake = false;
    nix-colors = {
      url = "github:misterio77/nix-colors";
      inputs.base16-schemes.follows = "base16-schemes";
    };

    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ludovico-nixpkgs.url = "github:AkukinKensetsu/nixpackages";
    devshell.url = "github:numtide/devshell";
    # emacs-overlay.url = "github:nix-community/emacs-overlay";
    flake-parts.url = "github:hercules-ci/flake-parts";
    impermanence.url = "github:nix-community/impermanence";
    nur.url = "github:nix-community/nur";
    nixos-flake.url = "github:srid/nixos-flake";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
}
