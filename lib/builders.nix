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
          (import ../hosts/${hostname} {
            inherit user pkgs inputs;
            inherit (nixpkgs) lib;
          })

          (import ../modules/home/config.nix {
            inherit specialArgs;
            inherit (args) system user hostname;
          })
          specialArgs.home-manager.darwinModules.home-manager

          (import ../modules/stylix {inherit pkgs theme;})
          specialArgs.stylix.darwinModules.stylix

          { programs.nix-index-database.comma.enable = true; }
          specialArgs.nix-index-database.darwinModules.nix-index

          ../modules/common
          ../modules/darwin
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
          (import ../hosts/${hostname} {
            inherit user pkgs inputs;
            inherit (nixpkgs) lib;
          })

          (import ../modules/home/config.nix {
            inherit specialArgs;
            inherit (args) system user hostname;
          })
          specialArgs.home-manager.nixosModules.home-manager

          specialArgs.disko.nixosModules.disko

          (import ../modules/stylix {inherit pkgs theme;})
          specialArgs.stylix.nixosModules.stylix

          { programs.nix-index-database.comma.enable = true; }
          specialArgs.nix-index-database.nixosModules.nix-index

          ../modules/common
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
