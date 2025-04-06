{nixpkgs}: {
  mkShell = {
    packages,
    system,
  } @ args: let
    pkgs = import nixpkgs {inherit (args) system;};
  in {
    default = pkgs.mkShell {
      name = "Fleet dev shell";
      packages = map (pkg: pkgs.${pkg}) args.packages;
    };
  };
}
