{
  # TODO: experiment with user settings here too
  environment.persistence."/persist" = {
    directories = [
      "/etc/ssh"
      "/var/lib/systemd"
      "/var/lib/NetworkManager"
      "/var/lib/nixos"
    ];
    files = ["/etc/machine-id"];
  };

  programs.fuse.userAllowOther = true;
}
