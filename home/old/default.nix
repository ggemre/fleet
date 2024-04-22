{
  lib,
  ...
}: {
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
