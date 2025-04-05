{
  inputs,
  nixpkgs,
  darwin,
  specialArgs,
  ...
}:
{
  mkDarwinSystem = {
    modules ? [],
    system,
    user,
    hostname,
    theme ? "catppuccin-mocha",
    ...
  } @ args:
  let
    allowedSystems = [ "x86_64-darwin" "aarch64-darwin" ];
  in

  assert builtins.elem system allowedSystems
    || throw ''
    Invalid system: "${system}"
    Allowed systems are:
      ${builtins.concatStringsSep "\n  " allowedSystems}
    '';

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
            home-manager.extraSpecialArgs = specialArgs // { inherit (args) system; };
            home-manager.users.${user} = import ../home/${user};
          }
          specialArgs.home-manager.darwinModules.home-manager
          (import ../hosts/${hostname} { inherit user; pkgs = import nixpkgs { inherit (args) system; }; inherit (nixpkgs) lib; })

          ../modules/common
          ../modules/darwin

          {
            stylix = {
              enable = true;
              base16Scheme = ../theme/${theme}.yaml;
            };
          }
          specialArgs.stylix.darwinModules.stylix
        ]
        ++ args.modules or [];
    };

  mkNixosSystem = {
    modules ? [],
    system,
    user,
    hostname,
    theme ? "catppuccin-mocha",
    ...
  } @ args:
  let
    allowedSystems = [ "x86_64-linux" "aarch64-linux" ];
  in

  assert builtins.elem system allowedSystems
    || throw ''
    Invalid system: "${system}"
    Allowed systems are:
      ${builtins.concatStringsSep "\n  " allowedSystems}
    '';

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
          home-manager.extraSpecialArgs = specialArgs // { inherit (args) system; };
          home-manager.users.${user} = import ../home/${user};
        }
        specialArgs.home-manager.nixosModules.home-manager
        (import ../hosts/${hostname} { inherit user; pkgs = import nixpkgs { inherit (args) system; }; inherit (nixpkgs) lib; })

        ../modules/common
        specialArgs.disko.nixosModules.disko

        {
          stylix = {
            enable = true;
            base16Scheme = ../theme/${theme}.yaml;
          };
        }
        specialArgs.stylix.nixosModules.stylix
      ]
      ++ args.modules or [];
    };

  mkNixosIso = {
    modules,
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
