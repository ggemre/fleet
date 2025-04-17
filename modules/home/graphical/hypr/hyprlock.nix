{config, ...}: {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        grace = 2;
        ignore_empty_input = true;
      };
      background = {
        path = "screenshot";
        blur_passes = 2;
        brightness = 0.5;
      };
      label = [
        {
          text = "$TIME";
          font_size = 30;
          font_family = "${config.stylix.fonts.sansSerif.name}";
          position = "0, 160";
          halign = "center";
          valign = "center";
        }
        {
          text = "Hi, $USER";
          font_size = 30;
          font_family = "${config.stylix.fonts.sansSerif.name}";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
      ];
      input-field = {
        position = "0, 0";
        size = "150, 25";
        dots_size = 0.33;
        dots_spacing = 0.15;
        font_family = "${config.stylix.fonts.sansSerif.name}";
        placeholder_text = "Password...";
        fail_text = "Try again";
      };
    };
  };
}
