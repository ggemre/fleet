{
  specialArgs,
  system,
  user,
  hostname,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = specialArgs // {inherit system;};
    users.${user} = import (../../home + "/${user}@${hostname}");
    backupFileExtension = "backup";
  };
}
