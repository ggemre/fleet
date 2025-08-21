{pkgs, ...}: {
  services.displayManager.ly = {
    enable = true;
    settings = {
      save = true;
      waylandsessions = "${pkgs.hyprland}/share/wayland-sessions"; # pull out to command?

      # none, doom, matrix, colormix, or gameoflife
      animation = "matrix";
    };
  };
}
