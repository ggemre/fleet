{
  nixpkgs,
  specialArgs,
  home-manager,
  ...
}:
{
  mkHome =
    {
      hostname,
      user,
      system,
      modules ? [],
      ...
    } @args:
    home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = specialArgs // { inherit (args) system; }; # NOTE: we're currently not using inputs in home-manager
      users.${user} = import ../home/${user};
      modules = args.modules or [];
    };
}
