{
  lib,
  user,
  system,
  ...
}: let
  homeDir =
    if lib.strings.hasSuffix "darwin" system
    then "/Users/${user}" # nix-darwin home directory
    else "/home/${user}"; # nixos home directory
in {
  home = {
    username = user;
    homeDirectory = homeDir;

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
