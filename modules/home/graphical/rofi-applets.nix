{
  rofi-applets,
  config,
  ...
}: {
  imports = [rofi-applets.homeManagerModules.rofi-applets];

  programs.rofi-applets = {
    enable = true;
    font = config.stylix.fonts.monospace.name;
    colors = {
      background = config.lib.stylix.colors.withHashtag.base00;
      backgroundAlt = config.lib.stylix.colors.withHashtag.base01;
      foreground = config.lib.stylix.colors.withHashtag.base05;
      selected = config.lib.stylix.colors.withHashtag.base07;
      active = config.lib.stylix.colors.withHashtag.base0D;
      urgent = config.lib.stylix.colors.withHashtag.base08;
    };

    launcher.enable = true;
    powermenu.enable = true;
    networkmanager.enable = true;
  };
}
