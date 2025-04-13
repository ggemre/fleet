_: {
  environment.sessionVariables = {
    XCURSOR_SIZE = 10;
    WLR_NO_HARDWARE_CURSORS = 1;
    WLR_RENDERER_ALLOW_SOFTWARE = 1;
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";

    # Set toolkit backends
    QT_QPA_PLATFORM = "wayland;xcb";
    GDK_BACKEND = "wayland,x11,*";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";

    # Application specifics
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_OZONE_WL = 1;
    MOZ_ENABLE_WAYLAND = 1;

    # QT specifics
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
}
