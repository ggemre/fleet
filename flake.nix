{
  description = "Nix flake to configure my entire \"fleet\" of systems.";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cache.privatevoid.net"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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

    stylix.url = "github:danth/stylix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    ...
  }: let
    specialArgs = inputs;
    utils = import ./lib/utils.nix {inherit nixpkgs;};
    builders = import ./lib/builders.nix {inherit inputs nixpkgs darwin specialArgs;};
    home = import ./lib/home.nix {inherit nixpkgs home-manager specialArgs;};
    shell = import ./lib/shell.nix {inherit nixpkgs;};
    pkgsHelper = import ./lib/pkgs.nix {inherit nixpkgs;};
  in {
    nixosConfigurations = {
      test = builders.mkNixosSystem {
        user = "gge";
        hostname = "nix-wrk-0404";
        system = "x86_64-linux";
        theme = "catppuccin-mocha";
      };
    };

    darwinConfigurations = {
      mre = builders.mkDarwinSystem {
        user = "gge";
        hostname = "dwn-wrk-0331";
        system = "x86_64-darwin";
        theme = "rose-pine";
      };
    };

    homeConfigurations = {
      gge = home.mkHome {
        user = "gge";
        system = "x86_64-linux";
      };
    };

    devShells = utils.forAllSystems (
      system:
        shell.mkShell {
          inherit system;

          packages = [
            "alejandra"
            "statix"
            "just"
            "deadnix"
            "nixd"
          ];

          internalPackages = [
            self.packages.${system}.hostnamegen
          ];
        }
    );

    formatter = utils.forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    packages = utils.forAllSystems (system: let
      internalPkgs = pkgsHelper {inherit system;};
    in {
      hostnamegen = internalPkgs.hostnamegen;
    });
  };
}
