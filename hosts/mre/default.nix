{
  lib,
  pkgs,
  ...
}: let 
  hostname = "mre"; 
  user = "gge";
in {
  imports = [
    ./system.nix
    ./homebrew.nix
  ];

  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  users.users."${user}" = {
    home = "/Users/${user}";
    description = user;
    shell = pkgs.zsh;
  };

  nix.settings.trusted-users = [user];


  nixpkgs.hostPlatform = "x86_64-darwin";
  nix.linux-builder.enable = true;
}
