{
  specialArgs,
  system,
  user,
  hostname,
  ...
}: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = specialArgs // {inherit system;};
  home-manager.users.${user} = import (../../home + "/${user}@${hostname}");
  home-manager.backupFileExtension = "backup";
}
