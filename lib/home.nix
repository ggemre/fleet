{
  nixpkgs,
  specialArgs,
  home-manager,
  ...
}: {
  mkHome = {
    user,
    system,
    theme ? "catppuccin-mocha",
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
        ../home/${user} # TODO: this doesn't exist, move or create
        (import ../modules/stylix {inherit pkgs theme;})
        specialArgs.stylix.homeManagerModules.stylix
      ];
    };
}
