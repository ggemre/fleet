{nixpkgs}: let
  systems = [
    "aarch64-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
  forAllSystems = nixpkgs.lib.genAttrs systems;
in {
  inherit forAllSystems;
}
