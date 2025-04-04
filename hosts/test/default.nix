{
  lib,
  pkgs,
  ...
}: let 
  hostname = "mre"; 
  user = "gge";
in {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  users.users."${user}" = {
    home = "/home/${user}";
    description = user;
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  programs.zsh.enable = true;

  # Most users should never change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  # https://mynixos.com/nixpkgs/option/system.stateVersion
  system.stateVersion = "24.11";
}
