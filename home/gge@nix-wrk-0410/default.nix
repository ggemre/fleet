{
  lib,
  pkgs,
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
    ../../modules/home/terminal/ghostty.nix
    ../../modules/home/tui/helix.nix
    ../../modules/home/tui/yazi.nix
    ../../modules/home/browser/schizofox.nix
    ../../modules/home/graphical/hyprland.nix
    ../../modules/home/graphical/waybar.nix
  ];

  home = {
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 10;
    };
  };
}
