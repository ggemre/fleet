{
  lib,
  pkgs,
  system,
  impermanence,
  ...
}: let
  user = "gge";
in {
  imports = [
    (import ../../modules/home/user.nix {inherit user system lib;})
    (import ./impermanence.nix {inherit user impermanence;})

    ../../modules/home/shell/zsh.nix
    ../../modules/home/shell/direnv.nix
    ../../modules/home/cli/eza.nix
    ../../modules/home/cli/git.nix
    ../../modules/home/tui/helix.nix
    ../../modules/home/tui/yazi.nix
  ];

  home = {
    packages = with pkgs; [
      # archives
      zip
      xz
      unzip
      p7zip

      # utils
      ripgrep
      bat
      just
    ];
  };
}
