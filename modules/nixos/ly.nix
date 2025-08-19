{
  pkgs,
  ...
}: {
  services.displayManager.ly = {
    enable = true;
    settings = {
      save = true;
      load = true;
      animation = "matrix";
      waylandsessions = "${pkgs.hyprland}/share/wayland-sessions"; # pull out to command?
    };
  };
}
