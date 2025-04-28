{
  pkgs,
  user,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ./stylix.nix
    ./impermanence.nix
    inputs.impermanence.nixosModules.impermanence
  ];

  users.users."${user}" = {
    home = "/home/${user}";
    description = user;
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
    hashedPassword = "";
  };
  users.mutableUsers = false;

  programs.zsh.enable = true;
  services.openssh = {
    enable = true;
    ports = [22];
  };

  # Most users should never change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  # https://mynixos.com/nixpkgs/option/system.stateVersion
  system.stateVersion = "24.11";
}
