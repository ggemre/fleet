{nixpkgs}: {system}: let
  pkgs = import nixpkgs {inherit system;};
in {
  mkhostname = pkgs.writeShellApplication {
    name = "mkhostname";

    runtimeInputs = with pkgs; [
      gum
    ];

    text = builtins.readFile ../pkgs/mkhostname.sh;
  };
}
