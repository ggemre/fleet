{config, ...}: {
  stylix.targets.waybar.enable = false;

  programs.waybar = {
    enable = true;
    systemd.enable = false; # let our wm start it
    settings = {
      main = {
        layer = "top";
        position = "top";
        modules-left = ["hyprland/workspaces" "cava"];
        modules-center = ["clock"];
        modules-right = ["network" "pulseaudio" "cpu" "memory" "disk" "battery" "custom/power"];
        "hyprland/workspaces" = {format = "";};
        clock = {
          interval = 60;
          format = "{:%I:%M %p %a %b %d}";
          format-alt = "{:%I:%M %p}";
          tooltip = false;
        };
        cava = {
          framerate = 30;
          autosens = 1;
          bars = 14;
          lower_cutoff_freq = 50;
          higher_cutoff_freq = 10000;
          sleep_timer = 0;
          input_delay = 2;
          hide_on_silence = true;
          method = "pulse";
          source = "auto";
          stereo = true;
          reverse = false;
          bar_delimiter = 0;
          monstercat = false;
          waves = false;
          noise_reduction = 0.87;
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          actions = {
            on-click-right = "mode";
          };
        };
        network = {
          format-wifi = "󰖩 {bandwidthTotalBytes}";
          format-ethernet = "󰈁 {bandwidthTotalBytes}";
          format-disconnected = "󰖪";
          tooltip = true;
          tooltip-format = "{ifname} via {gwaddr}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-ethernet = "{ifname}";
          tooltip-format-disconnected = "Disconnected";
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " ";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
        };
        cpu = {
          interval = 10;
          format = " {usage}%";
          max-length = 10;
        };
        memory = {
          interval = 30;
          format = " {}%";
          max-length = 10;
        };
        disk = {
          interval = 120;
          format = "󰆼 {percentage_used}%";
          path = "/";
        };
        battery = {
          interval = 60;
          states = {
            warning = 50;
            critical = 25;
          };
          format = "{icon} {capacity}%";
          format-charging = "󱐋{icon} {capacity}%";
          format-full = "󱐋{icon} {capacity}%";
          format-icons = [" " " " " " " " " "];
          bat-compatibility = true;
          full-at = 88;
          tooltip = true;
          tooltip-format = "{timeTo}";
        };
        "custom/power" = {
          format = "⏻";
          on-click = "rofi -show p -modi p:'rofi-power-menu --no-symbols'";
          tooltip = false;
        };
      };
    };
    style = ''
      * {
      	  border: none;
          font-family: "${config.stylix.fonts.monospace.name}";
      	  font-size: 12px;
      	  font-weight: bold;
          padding: 0px 0px 0px 0px;
        }
      	window#waybar {
      	  background: rgba(30, 30, 30, 0.3);
        }
      	#workspaces {
      	  border-radius: 10px;
      	  background-color: #${config.lib.stylix.colors.base00};
      	  color: #${config.lib.stylix.colors.base05};
          font-size: 7px;
          margin: 5px 0px 5px 8px;
          padding: 0px 10px 0px 10px;
      	}
      	#workspaces button {
      	  background-color: #${config.lib.stylix.colors.base00};
      	  color: #${config.lib.stylix.colors.base04};
      	  padding: 0;
      	  margin-top: 0;
      	}
        #workspaces button:hover {
          color: #${config.lib.stylix.colors.base07};
          background-color: #${config.lib.stylix.colors.base00};
        }
      	#workspaces button.active {
      	  color: #${config.lib.stylix.colors.base05};
      	}
      	#clock, #cava, #battery, #network, #pulseaudio, #cpu, #memory, #disk, #custom-power {
      	  border-radius: 10px;
      	  background-color: #${config.lib.stylix.colors.base00};
      	  color: #${config.lib.stylix.colors.base05};
          margin: 5px 8px 5px 0px;
          padding: 0px 10px 0px 10px;
      	}
        #clock {
          color: #${config.lib.stylix.colors.base0C};
          margin-left: 8px;
        }
        #cava {
          color: #${config.lib.stylix.colors.base03};
          margin-left: 5px;
        }
        #network {
          color: #${config.lib.stylix.colors.base0D};
        }
        #network.disconnected {
          color: #${config.lib.stylix.colors.base08};
        }
        #pulseaudio {
          color: #${config.lib.stylix.colors.base09};
          border-radius: 10px 0px 0px 10px;
          margin-right: 0;
          padding: 0px 12px 0px 10px;
        }
        #cpu {
          color: #${config.lib.stylix.colors.base0A};
          border-radius: 0;
          margin-right: 0;
          padding: 0px 12px 0px 0px;
        }
        #memory {
          color: #${config.lib.stylix.colors.base0F};
          border-radius: 0;
          margin-right: 0;
          padding: 0px 12px 0px 0px;
        }
        #disk {
          color: #${config.lib.stylix.colors.base0E};
          border-radius: 0px 10px 10px 0px;
          padding: 0px 10px 0px 0px;
        }
        #battery {
          color: #${config.lib.stylix.colors.base0B};
        }
        #battery.warning {
          color: #${config.lib.stylix.colors.base0A};
        }
        #battery.critical {
          color: #${config.lib.stylix.colors.base08};
        }
        #custom-power {
          color: #${config.lib.stylix.colors.base01};
          background-color: #${config.lib.stylix.colors.base08};
          padding-left: 8px;
        }
    '';
  };
}
