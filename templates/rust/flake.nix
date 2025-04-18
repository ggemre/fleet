{
  description = "Rust flake using crane";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    crane.url = "github:ipetkov/crane";
  };

  outputs = {
    nixpkgs,
    crane,
    ...
  }: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    eachDefaultSystem = f:
      builtins.listToAttrs (map (system: {
          name = system;
          value = f system;
        })
        systems);
  in {
    packages = eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      craneLib = crane.mkLib pkgs;

      src = craneLib.cleanCargoSource ./.;
      commonArgs = {inherit src;};

      cargoArtifacts = craneLib.buildDepsOnly commonArgs;

      my-crate = craneLib.buildPackage (commonArgs
        // {
          inherit cargoArtifacts;
        });
    in {
      default = my-crate;
    });

    apps = eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      craneLib = crane.mkLib pkgs;

      src = craneLib.cleanCargoSource ./.;
      cargoArtifacts = craneLib.buildDepsOnly {inherit src;};
      my-crate = craneLib.buildPackage {
        inherit src cargoArtifacts;
      };
    in {
      default = {
        type = "app";
        program = "${my-crate}/bin/${my-crate.pname}";
        meta = {
          description = "Description for my rust project";
        };
      };
    });

    devShells = eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      craneLib = crane.mkLib pkgs;
    in {
      default = craneLib.devShell {};
    });

    checks = eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      craneLib = crane.mkLib pkgs;

      src = craneLib.cleanCargoSource ./.;
      commonArgs = {inherit src;};
      cargoArtifacts = craneLib.buildDepsOnly commonArgs;

      tests = craneLib.cargoTest (commonArgs // {inherit cargoArtifacts;});
      clippy = craneLib.cargoClippy (commonArgs
        // {
          inherit cargoArtifacts;
          cargoClippyExtraArgs = "--all-targets --all-features";
        });
      fmt = craneLib.cargoFmt {inherit src;};
    in {
      inherit tests clippy fmt;
    });
  };
}
