_: {
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 150; # 2m 30s
          on-timeout = "brightnessctl set 0 --save && brightnessctl --device=tpacpi::kbd_backlight set 0 --save";
          on-resume = "brightnessctl --restore && brightnessctl --device=tpacpi::kbd_backlight --restore";
        }
        {
          timeout = 300; # 5m
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 380; # 6m 20s
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800; # 30m
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
