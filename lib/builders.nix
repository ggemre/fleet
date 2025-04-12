{
  inputs,
  nixpkgs,
  darwin,
  specialArgs,
  ...
}: {
  mkDarwinSystem = {
    system,
    user,
    hostname,
    theme ? "catppuccin-mocha",
    ...
  } @ args: let
    allowedSystems = ["x86_64-darwin" "aarch64-darwin"];
    pkgs = import nixpkgs {inherit (args) system;};
  in
    assert builtins.elem system allowedSystems
    || throw ''
      Invalid system: "${system}"
      Allowed systems are:
        ${builtins.concatStringsSep "\n  " allowedSystems}
    '';
      darwin.lib.darwinSystem {
        inherit specialArgs;
        modules = [
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
            home-manager.extraSpecialArgs = specialArgs // {inherit (args) system;};
            home-manager.users.${args.user} = import (../home + "/${args.user}@${args.hostname}");
            home-manager.backupFileExtension = "backup";
          }
          specialArgs.home-manager.darwinModules.home-manager
          (import ../hosts/${hostname} {
            inherit user;
            inherit pkgs;
            inherit (nixpkgs) lib;
          })

          ../modules/common
          ../modules/darwin

          {
            stylix = {
              enable = true;
              base16Scheme = ../theme/${theme}.yaml;
            };
          }
          specialArgs.stylix.darwinModules.stylix
        ];
      };

  mkNixosSystem = {
    system,
    user,
    hostname,
    theme ? "catppuccin-mocha",
    ...
  } @ args: let
    allowedSystems = ["x86_64-linux" "aarch64-linux"];
    pkgs = import nixpkgs {inherit (args) system;};
  in
    assert builtins.elem system allowedSystems
    || throw ''
      Invalid system: "${system}"
      Allowed systems are:
        ${builtins.concatStringsSep "\n  " allowedSystems}
    '';
      nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          {
            config = {
              networking.hostName = args.hostname;
              nixpkgs.hostPlatform = args.system;
            };
          }

          {
            # TODO: move to modules/home
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs // {inherit (args) system;};
            home-manager.users.${args.user} = import (../home + "/${args.user}@${args.hostname}");
            home-manager.backupFileExtension = "backup";
          }
          specialArgs.home-manager.nixosModules.home-manager
          (import ../hosts/${hostname} {
            inherit user;
            inherit pkgs;
            inherit (nixpkgs) lib;
          })

          ../modules/common
          specialArgs.disko.nixosModules.disko

          {
            stylix = {
              # TODO: we should move this stuff out somewhere
              enable = true;
              base16Scheme = ../theme/${theme}.yaml;
              fonts = {
                sansSerif = {
                  package = pkgs.fira-code;
                  name = "Fira Code";
                };
              };
            };
          }
          specialArgs.stylix.nixosModules.stylix
        ];
      };

  mkNixosIso = {
    modules ? [],
    hostname,
    system,
    ...
  } @ args:
    nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      inherit system;
      modules =
        [
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"

          {config.networking.hostName = args.hostname;}

          ../hosts/${hostname}
        ]
        ++ args.modules or [];
    };
}
