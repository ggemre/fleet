{ nixpkgs }:

{
  mkShell = { packages, internalPackages ? [], system }:
    let
      pkgs = import nixpkgs { inherit system; };

      normalize = pkg:
        if builtins.isString pkg then pkgs.${pkg} else pkg;

      finalPackages = builtins.map normalize (packages ++ internalPackages);
    in {
      default = pkgs.mkShell {
        name = "Fleet dev shell";
        packages = finalPackages;
      };
    };
}
