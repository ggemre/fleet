{
  nixpkgs,
  specialArgs,
  home-manager,
  ...
}: {
  mkHome = {
    user,
    system,
    modules ? [],
    theme ? "catppuccin-mocha",
    ...
  } @ args:
    home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = specialArgs // {inherit (args) system;};
      modules =
        [
          ../home/${user}
          {
            stylix = {
              enable = true;
              base16Scheme = ../theme/${theme}.yaml;
            };
          }
          specialArgs.stylix.homeManagerModules.stylix
        ]
        ++ args.modules or [];
    };
}
