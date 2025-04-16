{
  description = "Rust Hello World with crane and tests";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    crane.url = "github:ipetkov/crane";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    crane,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };

      craneLib = crane.mkLib pkgs;

      src = craneLib.cleanCargoSource ./.;

      commonArgs = {
        inherit src;
      };

      cargoArtifacts = craneLib.buildDepsOnly commonArgs;

      my-crate = craneLib.buildPackage (commonArgs
        // {
          inherit cargoArtifacts;
        });

      tests = craneLib.cargoTest (commonArgs
        // {
          inherit cargoArtifacts;
        });

      clippy = craneLib.cargoClippy (commonArgs
        // {
          inherit cargoArtifacts;
          cargoClippyExtraArgs = "--all-targets --all-features";
        });

      fmt = craneLib.cargoFmt {inherit src;};
    in {
      packages.default = my-crate;

      apps.default = {
        type = "app";
        program = "${my-crate}/bin/${my-crate.pname}";
        meta = {
          description = "Description for my rust project";
        };
      };

      devShells.default = craneLib.devShell {};

      checks = {
        inherit tests clippy fmt;
      };
    });
}
