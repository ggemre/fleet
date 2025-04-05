{ nixpkgs }:

let
  mkShells = { packages, systems }:
    nixpkgs.lib.genAttrs systems (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        default = pkgs.mkShell {
          packages = map (pkg: pkgs.${pkg}) packages;
        };
      }
    );
in {
  inherit mkShells;
}
