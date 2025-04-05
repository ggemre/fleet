{ nixpkgs }:
{
  mkShells = { packages, systems } @args:
    nixpkgs.lib.genAttrs args.systems (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        default = pkgs.mkShell {
          packages = map (pkg: pkgs.${pkg}) args.packages;
        };
      }
    );
}
