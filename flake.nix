{
  description = "Nix flake to configure my entire \"fleet\" of systems.";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cache.privatevoid.net"
      "https://anyrun.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.privatevoid.net:SErQ8bvNWANeAvtsOESUwVYr2VJynfuc9JRwlzTTkVg="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
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

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    stylix.url = "github:danth/stylix";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpapers = {
      url = "github:ggemre/wallpapers";
      flake = false;
    };

    schizofox.url = "github:schizofox/schizofox";

    anyrun.url = "github:anyrun-org/anyrun";
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
    templatesHelper = import ./templates;
  in {
    nixosConfigurations = {
      test = builders.mkNixosSystem {
        user = "gge";
        hostname = "nix-wrk-0404";
        system = "x86_64-linux";
      };

      main = builders.mkNixosSystem {
        user = "gge";
        hostname = "nix-wrk-0410";
        system = "x86_64-linux";
      };

      iso1 = builders.mkNixosIso {
        hostname = "nix-iso-0409";
        system = "x86_64-linux";
      };
    };

    darwinConfigurations = {
      mre = builders.mkDarwinSystem {
        user = "gge";
        hostname = "dwn-wrk-0331";
        system = "x86_64-darwin";
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
            "bash-language-server"
            "shfmt"
          ];

          internalPackages = [
            self.packages.${system}.mkhostname
          ];
        }
    );

    formatter = utils.forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    packages = utils.forAllSystems (system: let
      internalPkgs = pkgsHelper {inherit system;};
    in {
      inherit (internalPkgs) mkhostname;
    });

    templates = templatesHelper;
  };
}
