{
  nixpkgs,
  specialArgs,
  home-manager,
  ...
}: {
  mkHome = {
    user,
    system,
    ...
  } @ args: let
    pkgs = import nixpkgs {
      inherit (args) system;
      overlays = [specialArgs.nur.overlays.default];
    };
  in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs =
        specialArgs
        // {
          inherit pkgs;
          inherit (args) system;
        };
      modules = [
        ../home/standalone/${user}
        specialArgs.stylix.homeManagerModules.stylix
      ];
    };
}
