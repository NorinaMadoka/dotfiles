{
  description = "A very basic flake";

  inputs = {
    # Nixpkgs branches
    master.url = "github:nixos/nixpkgs/master";
    stable.url = "github:nixos/nixpkgs/nixos-21.11";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Default nixpkgs for packages and modules
    nixpkgs.follows = "unstable";

    # Flake inputs
    emacs.url = "github:nix-community/emacs-overlay";
    home.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/hyprland";
    impermanence.url = "github:nix-community/impermanence";
    nix.url = "github:nixos/nix";
    nix-colors.url = "github:Misterio77/nix-colors";
    statix.url = "github:nerdypepper/statix";

    # Minimize duplicate instances of inputs
    home.inputs.nixpkgs.follows = "nixpkgs";
    emacs.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.inputs.nixpkgs.follows = "nixpkgs";
    nix.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.inputs.nixpkgs.follows = "nixpkgs";
    statix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    home,
    nixpkgs,
    ...
  } @ inputs: let
    config = {
      allowBroken = true;
      allowUnfree = true;
    };

    filterNixFiles = k: v: v == "regular" && nixpkgs.lib.hasSuffix ".nix" k;

    importNixFiles = path:
      with nixpkgs.lib;
        (lists.forEach (mapAttrsToList (name: _: path + ("/" + name))
            (filterAttrs filterNixFiles (builtins.readDir path))))
        import;

    overlays = with inputs;
      [emacs.overlay]
      # Overlays from ./overlays directory
      ++ (importNixFiles ./overlays);
  in {
    nixosConfigurations = {
      sforza = import ./hosts/sforza {
        inherit config nixpkgs overlays inputs;
      };
    };

    homeConfigurations = {
      ludovico = import ./users/ludovico {
        inherit config nixpkgs home overlays inputs;
      };
    };

    sforza = self.nixosConfigurations.sforza.config.system.build.toplevel;

    nixConfig = {
      substituters = [
        #TODO: add more
        "https://cache.nixos.org?priority=10"
      ];
    };
  };
}
