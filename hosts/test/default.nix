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
}
