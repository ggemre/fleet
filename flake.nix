{
  description = "TODO: write a description";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      # "https://nix-gaming.cachix.org"
      # "https://hyprland.cachix.org"
      "https://cache.privatevoid.net"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.privatevoid.net:SErQ8bvNWANeAvtsOESUwVYr2VJynfuc9JRwlzTTkVg="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    disko,
    ...
  }: let
    specialArgs = inputs;
    builders = import ./lib/builders.nix {inherit inputs nixpkgs darwin specialArgs;};
  in {
    nixosConfigurations = {
      test = builders.mkNixosSystem {
        user = "gge";
        hostname = "test";
        system = "x86_64-linux";
        modules = [
          ./hosts/test # NOTE: do we want to move these to the builder? (i.e. will ./hosts/hostname always be imported?)
          ./modules/nix-core.nix # NOTE: see above
          disko.nixosModules.disko # NOTE: are we going to use disko for EVERY nixos host?
        ];
      };
    };
    darwinConfigurations = {
      mre = builders.mkDarwinSystem {
        user = "gge";
        hostname = "mre";
        system = "x86_64-darwin";
        modules = [
          ./hosts/mre # NOTE: see above
          ./modules/nix-core.nix # NOTE: see above
        ];
      };
    };
  };
}
