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
        ]
        ++ args.modules or [];
    };

  mkNixosSystem = {
    modules,
    system,
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
