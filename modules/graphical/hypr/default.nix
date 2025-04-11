{
  pkgs,
  ...
}: {
  # TODO: this is going to get moved to a separate file and other files for other wayland stuff will be added
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --asterisks --cmd Hyprland";
        user = "gge"; # TODO: please abstract this out
      };
    };
  };
}
