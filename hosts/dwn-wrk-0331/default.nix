{
  pkgs,
  user,
  ...
}: {
  imports = [
    ./system.nix
    ./homebrew.nix
    ./stylix.nix
    ../../modules/darwin
  ];

  users.users."${user}" = {
    home = "/Users/${user}";
    description = user;
    shell = pkgs.zsh;
  };

  nix.settings.trusted-users = [user];
  nix.linux-builder.enable = true;
}
