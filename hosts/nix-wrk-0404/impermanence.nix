{
  environment.persistence."/persist" = {
    directories = [
      "/etc/ssh"
      "/var/lib/systemd"
      "/var/lib/NetworkManager"
      "/var/lib/nixos"
    ];
    files = ["/etc/machine-id"];
  };
}
