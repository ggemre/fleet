{ config, hostType, lib, ... }:
if hostType == "nixos" || hostType == "darwin" then {
  imports = [
    (
      if hostType == "nixos" then ./nixos.nix
      else if hostType == "darwin" then ./darwin.nix
      else throw "No sysConfig for hostType '${hostType}'"
    )
  ];
  home-manager.users.gge = {
    imports = [
      ../core
      # ../dev
      # ./modules
      ../old # TODO: temp test
    ];
    home.username = config.users.users.gge.name;
    # home.uid = config.users.users.gge.uid;
  };
}
else if hostType == "home-manager" then {
  imports = [
    ./core
    ./dev
    ./modules
  ];
  programs.home-manager.enable = true;
} else throw "Unknown hostType '${hostType}'"
