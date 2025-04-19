{
  sherlock,
  config,
  ...
}: {
  imports = [sherlock.homeManagerModules.default];

  programs.sherlock = {
    enable = true;
    settings = {
      config = {
        debug = {
          try_suppress_warnings = true;
        };
      };
      launchers = [
        {
          name = "App Launcher";
          type = "app_launcher";
          args = {};
          priority = 1;
          home = true;
        }
        {
          name = "Clipboard";
          type = "clipboard-execution";
          args = {};
          priority = 1;
          home = true;
        }
        {
          name = "Calculator";
          type = "calculation";
          args = {};
          priority = 1;
        }
        {
          name = "Power Management";
          alias = "pm";
          type = "command";
          args = {
            commands = {
              Shutdown = {
                icon = "system-shutdown";
                exec = "systemctl poweroff";
                search_string = "poweroff;shutdown";
              };
              Sleep = {
                icon = "system-suspend";
                exec = "systemctl suspend";
                search_string = "sleep;suspend";
              };
              Lock = {
                icon = "system-lock-screen";
                exec = "hyprlock";
                search_string = "lock";
              };
              Reboot = {
                icon = "system-reboot";
                exec = "systemctl reboot";
                search_string = "reboot;restart";
              };
            };
          };
          priority = 4;
        }
      ];
    };
  };

  home.file.".config/sherlock/main.css".text = ''
    overshoot *,
    undershoot *,
    overshoot.top,
    overshoot.right,
    overshoot.bottom,
    overshoot.left undershoot.top,
    undershoot.right,
    undershoot.bottom,
    undershoot.left,
    .scroll-window>*,
    overshoot:backdrop {
        background: none;
        border: none;
        background-color: transparent;
    }

    * {
        padding: 0px;
        margin: 0px;
        -gtk-secondary-caret-color: ${config.lib.stylix.colors.withHashtag.base00};
        outline-width: 0px;
        outline-offset: -3px;
        outline-style: dashed;
        line-height: 1;
        font-family: "${config.stylix.fonts.sansSerif.name}";
    }

    #overlay spinner {
        color: ${config.lib.stylix.colors.withHashtag.base05};
    }

    #overlay * {
        background: transparent;
    }

    .notifications {
        background: transparent;
    }

    window {
        background: transparent;
    }


    window {
        background: ${config.lib.stylix.colors.withHashtag.base00};
    }

    scrolledwindow>viewport,
    scrolledwindow>viewport>* {
        background: transparent;
    }

    label {
        color: ${config.lib.stylix.colors.withHashtag.base05};
    }


    window {
        color: ${config.lib.stylix.colors.withHashtag.base05};
        border-radius: 5px;
        border: 2px solid ${config.lib.stylix.colors.withHashtag.base0D};
    }

    /* STATUS BAR */
    .status-bar {
        background: ${config.lib.stylix.colors.withHashtag.base02};
        border-top: none;
        padding: 4px 10px 4px 20px;
    }

    .status-bar label {
        color: ${config.lib.stylix.colors.withHashtag.base05};
    }

    .spinner-disappear {
        animation: vanish-rotate 0.3s ease forwards;
    }

    .spinner-appear {
        animation: ease-opacity 0.3s ease forwards;
        animation: rotate 0.3s linear infinite;
    }


    /* SEARCH PAGE */
    #search-bar {
        outline: none;
        border: none;
        background: transparent;
        min-height: 40px;
        color: ${config.lib.stylix.colors.withHashtag.base05};
        font-size: 15px;
        padding-left: 20px;
    }

    #search-bar-holder {
        border-bottom: ${config.lib.stylix.colors.withHashtag.base0D};
        border-bottom: none;
        padding: 5px 10px 4px 10px;
    }

    #search-icon-holder image {
        transition: 0.1s ease;
    }

    #search-icon-holder.search image:nth-child(1) {
        transition-delay: 0.05s;
        opacity: 1;
    }

    #search-icon-holder.search image:nth-child(2) {
        transform: rotate(-180deg);
        opacity: 0;
    }

    #search-icon-holder.back image:nth-child(1) {
        opacity: 0;
    }

    #search-icon-holder.back image:nth-child(2) {
        transition-delay: 0.05s;
        opacity: 1;
    }


    #search-icon {
        margin-left: 10px;
    }

    #search-bar:focus {
        outline: none;
    }

    #search-bar placeholder {
        background: transparent;
        background-color: transparent;
        color: ${config.lib.stylix.colors.withHashtag.base05};
        font-weight: 500;
    }

    #category-type {
        font-size: 13px;
        font-weight: bold;
        color: ${config.lib.stylix.colors.withHashtag.base05};
        opacity: 0.3;
        padding: 10px 20px 0px 20px;
    }

    .scrolled-window {
        padding: 10px 10px 5px 10px;
    }

    scrollbar {
        transform: translate(8px, 0px);
        border: none;
        background: none;
    }

    scrollbar slider {
        background: ${config.lib.stylix.colors.withHashtag.base05};
        border: none;
    }

    image {
        color: white;
    }

    .tile {
        outline: none;
        min-height: 50px;
        padding: 0px 10px;
        margin-bottom: 5px;
        border-radius: 4px;
    }

    .tile:hover *,
    .tile:hover {
        background: transparent;
    }

    .tile.animate {
        transform: translateY(20px);
        opacity: 0;
        animation: fadeInUp 0.2s ease-out forwards;
    }

    .tile.animate:nth-child(1) {
        animation-delay: 0.05s;
    }

    .tile.animate:nth-child(2) {
        animation-delay: 0.1s;
    }

    .tile.animate:nth-child(3) {
        animation-delay: 0.15s;
    }

    .tile.animate:nth-child(4) {
        animation-delay: 0.2s;
    }

    .tile.animate:nth-child(5) {
        animation-delay: 0.25s;
    }

    .tile.animate:nth-child(6) {
        animation-delay: 0.3s;
    }

    .tile.animate:nth-child(7) {
        animation-delay: 0.35s;
    }

    .tile.animate:nth-child(8) {
        animation-delay: 0.4s;
    }

    .tile.animate:nth-child(9) {
        animation-delay: 0.45s;
    }

    .tile.animate:nth-child(10) {
        animation-delay: 0.5s;
    }

    @keyframes fadeInUp {
        from {
            letter-spacing: 1px;
            opacity: 0;
            transform: translateY(20px);
        }

        to {
            letter-spacing: 0px;
            opacity: 1;
            transform: translate(0px);
        }
    }

    .tile #title {
        font-size: 15px;
        color: ${config.lib.stylix.colors.withHashtag.base05};
    }

    .tile #icon {
        margin: 0px;
        padding: 0px;
    }

    .tile:selected {
        transition: 0.1s ease;
        background: ${config.lib.stylix.colors.withHashtag.base02};
        background-color: ${config.lib.stylix.colors.withHashtag.base02};
        outline: none;
        border: none;
    }

    .tile:selected .tag,
    .tag {
        font-size: 11px;
        border-radius: 3px;
        padding: 2px 8px;
        color: ${config.lib.stylix.colors.withHashtag.base08};
        box-shadow: 0px 0px 10px 0px rgba(2, 2, 2, 0.4);
        border: 1px solid ${config.lib.stylix.colors.withHashtag.base05};
        margin-left: 7px;
    }

    .tile:selected .tag-start,
    .tag-start {
        background: ${config.lib.stylix.colors.withHashtag.base01};
    }

    .tile:selected .tag-end,
    .tag-end {
        background: ${config.lib.stylix.colors.withHashtag.base0B};
    }

    .tile:focus {
        outline: none;
    }

    #launcher-type {
        font-size: 10px;
        color: ${config.lib.stylix.colors.withHashtag.base05};
        margin-left: 0px;
    }

    #color-icon-holder {
        border-radius: 50px;
    }


    /*SHORTCUT*/
    #shortcut-holder {
        margin-right: 25px;
        padding: 5px 10px;
        background: ${config.lib.stylix.colors.withHashtag.base02};
        border-radius: 5px;
        border: 1px solid ${config.lib.stylix.colors.withHashtag.base05};
        box-shadow: 0px 0px 6px 0px rgba(15, 15, 15, 1);
    }

    .tile:selected #shortcut-holder {
        background: ${config.lib.stylix.colors.withHashtag.base00};
        background-color: ${config.lib.stylix.colors.withHashtag.base00};
        color: ${config.lib.stylix.colors.withHashtag.base05};
        box-shadow: 0px 0px 6px 0px rgba(22, 22, 22, 1);
    }

    #shortcut,
    #shortcut-modkey {
        background: ${config.lib.stylix.colors.withHashtag.base00};
        background-color: ${config.lib.stylix.colors.withHashtag.base00};
        color: ${config.lib.stylix.colors.withHashtag.base05};
        font-size: 11px;
        font-weight: bold;
    }

    #shortcut-modkey {
        font-size: 13px;
    }


    /*CALCULATOR*/
    .calc-tile {
        padding: 10px 10px 20px 10px;
        border-radius: 5px;
    }

    #calc-tile-quation {
        font-size: 10px;
        color: gray;
    }

    #calc-tile-result {
        font-size: 25px;
        color: gray;
    }

    /*EVENT TILE*/
    .tile.tile.event-tile {
        padding: 5px 10px;
    }

    .tile.event-tile #title-label {
        padding: 2px 0px 7px 5px;
        text-transform: capitalize;
    }

    .tile.event-tile #time-label {
        font-size: 3rem;
    }

    #end-time-label {
        color: gray;
    }

    /* BULK TEXT TILE */
    .bulk-text {
        padding-bottom: 10px;
        min-height: 50px;
    }

    #bulk-text-title {
        margin-left: 10px;
        padding: 10px 0px;
        font-size: 10px;
        color: gray;
    }

    #bulk-text-content-title {
        font-size: 17px;
        font-weight: bold;
        color: ${config.lib.stylix.colors.withHashtag.base05};
        min-height: 20px;
    }

    #bulk-text-content-body {
        font-size: 14px;
        color: ${config.lib.stylix.colors.withHashtag.base05};
        line-height: 1.4;
        min-height: 20px;
    }

    /* MPRIS TILE*/
    #mpris-icon-holder {
        border-radius: 5px;
    }

    /*Animation for replacing album covers*/
    .image-replace-overlay #album-cover {
        opacity: 1;
        animation: ease-opacity 0.5s forwards;
    }

    /* NEXT PAGE */
    .next_tile {
        color: ${config.lib.stylix.colors.withHashtag.base05};
        background: ${config.lib.stylix.colors.withHashtag.base00};
    }

    .next_tile #content-body {
        color: ${config.lib.stylix.colors.withHashtag.base05};
        background: ${config.lib.stylix.colors.withHashtag.base00};
        padding: 10px;
    }

    .raw_text,
    .next_tile #content-body {
        font-family: '${config.stylix.fonts.monospace.name}', monospace;
        font-feature-settings: "kern" off;
        font-kerning: None;
    }

    /*Error*/
    .error-tile #scroll-window {
        padding: 10px;
        min-height: 50px;
    }

    .error-tile {
        border-radius: 4px;
        padding: 5px 10px 10px 10px;
        color: white;
        border: 1px solid transparent;
        margin-bottom: 10px;
    }

    .error-tile * {
        background: transparent;
    }

    .error {
        border: 1px solid ${config.lib.stylix.colors.withHashtag.base08};
        background: ${config.lib.stylix.colors.withHashtag.base0F};
    }

    .warning {
        border: 1px solid ${config.lib.stylix.colors.withHashtag.base0A};
        background: ${config.lib.stylix.colors.withHashtag.base09};
    }

    .error-tile #title {
        padding: 10px;
        font-size: 10px;
        color: gray;
    }

    .error-tile #content-title {
        margin-left: 10px;
        font-size: 16px;
        font-weight: bold;
        color: ${config.lib.stylix.colors.withHashtag.base05};
    }

    .error-tile #content-body {
        margin-left: 10px;
        font-size: 14px;
        color: ${config.lib.stylix.colors.withHashtag.base05};
        line-height: 1.4;
        color: gray;
    }

    @keyframes slide {
        from {
            transform: translate(0px, 0px);
        }

        to {
            transform: translate(-20px, 0px);
        }
    }

    /*ANIMATIONS*/
    @keyframes vanish-rotate {
        from {
            opacity: 1;
        }

        to {
            opacity: 0;
            transform: rotate(360deg);
        }

    }

    @keyframes rotate {
        from {
            transform: rotate(0deg);
            --start-rotation: 0deg;
        }

        to {
            transform: rotate(360deg);
            --start-rotation: 360deg;
        }

    }

    @keyframes ease-opacity {
        from {
            opacity: 0;
        }

        to {
            opacity: 1;
        }

    }

    @keyframes slide {
        from {
            transform: translate(0px, 0px);
        }
        to {
            transform: translate(-20px, 0px);
        }
    }
  '';
}
