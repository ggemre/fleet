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
    nixpkgs,
    darwin,
    home-manager,
    ...
  }: let
    specialArgs = inputs;
    builders = import ./lib/builders.nix { inherit inputs nixpkgs darwin specialArgs; };
    homes = import ./lib/home.nix { inherit nixpkgs home-manager specialArgs; };
    shell = import ./lib/shell.nix { inherit nixpkgs; };
  in {

    nixosConfigurations = {
      test = builders.mkNixosSystem {
        user = "gge";
        hostname = "test";
        system = "x86_64-linux";
      };
    };

    darwinConfigurations = {
      mre = builders.mkDarwinSystem {
        user = "gge";
        hostname = "mre";
        system = "x86_64-darwin";
      };
    };

    homeConfigurations = {
      gge = homes.mkHome {
        user = "gge";
        system = "x86_64-linux";
      };
    };
 
    devShells = shell.mkShells {
      packages = [ "statix" "just" "deadnix" ];
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    };
  };
}
