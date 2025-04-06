{ nixpkgs }:
{
  mkShell = { packages, system } @args:
    let
      pkgs = import nixpkgs { inherit (args) system; };
    in {
      default = pkgs.mkShell {
        packages = map (pkg: pkgs.${pkg}) args.packages;
      };
    };
}
