{
  lib,
  user,
  ...
}: {
  # import sub modules
  imports = [
    ./shell.nix
    ./core.nix
    ./git.nix
    ./starship.nix
    ./kitty.nix
    ./helix.nix
    ./direnv.nix
  ];
}
