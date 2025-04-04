{
  inputs,
  nixpkgs,
  darwin,
  specialArgs,
  ...
}:
{
  mkDarwinSystem = {
    modules,
    system,
    user,
    hostname,
    ...
  } @ args:
    darwin.lib.darwinSystem {
      inherit specialArgs;
      modules =
        [
          {
            config = {
              networking.hostName = args.hostname;
              networking.computerName = args.hostname;
              system.defaults.smb.NetBIOSName = args.hostname;
              nixpkgs.hostPlatform = args.system;
            };
          }
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs // { system = args.system; }; # NOTE: we're currently not using inputs in home-manager
            home-manager.users.${user} = import ../home/${user};
          }
          specialArgs.home-manager.darwinModules.home-manager
        ]
        ++ args.modules or [];
    };

  mkNixosSystem = {
    modules,
    system,
    user,
    hostname,
    ...
  } @ args:
    nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      modules =
      [
        {
          config = {
            networking.hostName = args.hostname;
            nixpkgs.hostPlatform = args.system;
          };
        }
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs // { system = args.system; }; # NOTE: see above
          home-manager.users.${user} = import ../home/${user};
        }
        specialArgs.home-manager.nixosModules.home-manager
      ]
      ++ args.modules or [];
    };

  mkNixosIso = {
    modules,
    system,
    hostname,
    ...
  } @ args:
    nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      modules =
        [
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"

          {config.networking.hostName = args.hostname;}
        ]
        ++ args.modules or [];
    };
}
