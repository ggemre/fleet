{
  nixpkgs,
  specialArgs,
  home-manager,
  ...
}:
{
  mkHome =
    {
      user,
      system,
      modules ? [],
      theme ? "catppuccin-mocha"
      ...
    } @args:
    home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs // { inherit (args) system; };
          home-manager.users.${user} = import ../home/${user};
        }

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
