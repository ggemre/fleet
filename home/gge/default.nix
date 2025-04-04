{
  lib,
  system,
  ...
}:
let user = "gge";
in
    builtins.trace system
{
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
    homeDirectory = "/Users/${user}"; # TODO: We mkForce to override users.users.gge.home, fix this later

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
