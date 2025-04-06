{nixpkgs}: {system}: let
  pkgs = import nixpkgs {inherit system;};
in {
  hostnamegen = pkgs.writeShellApplication {
    name = "hostnamegen";

    runtimeInputs = with pkgs; [
      gum
    ];

    text = builtins.readFile ../pkgs/hostname_gen.sh;
  };
}
