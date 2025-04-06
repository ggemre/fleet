{
  lib,
  system,
  ...
}: let
  user = "gge";
  homeDir =
    if lib.strings.hasSuffix "darwin" system
    then "/Users/${user}" # nix-darwin home directory
    else "/home/${user}"; # nixos home directory
in {
  imports = [
    ./shell.nix
    ./core.nix
    ./git.nix
    ./starship.nix
    ./kitty.nix
    ./helix.nix
    ./direnv.nix
  ];

  home = {
    username = user;
    homeDirectory = lib.mkForce homeDir; # We mkForce to override users.users.${user}.home since this one has system check

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
