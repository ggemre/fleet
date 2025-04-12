{
  lib,
  system,
  ...
}: let
  user = "gge";
in {
  imports = [
    (import ../../modules/home/user.nix {inherit user system lib;})

    ../../modules/home/shell/zsh.nix
    ../../modules/home/shell/starship.nix
    ../../modules/home/cli/core.nix
    ../../modules/home/cli/git.nix
    ../../modules/home/terminal/kitty.nix
    ../../modules/home/tui/helix.nix
    ../../modules/home/tui/yazi.nix
  ];
}
