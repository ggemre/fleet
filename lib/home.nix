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
      ]
      ++ args.modules or [];
    };
}
