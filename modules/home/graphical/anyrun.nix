{
  anyrun,
  pkgs,
  config,
  ...
}: {
  programs.anyrun = {
    enable = true;
    config = {
      plugins = with anyrun.packages.${pkgs.system}; [
        applications
        dictionary
        # randr
        rink
        symbols
        # shell
        # stdin
        translate
        # websearch
      ];
      x = {fraction = 0.5;};
      y = {fraction = 0.3;};
      width = {fraction = 0.3;};
      layer = "top";
      hideIcons = true;
      hidePluginInfo = true;
      maxEntries = 15;
      showResultsImmediately = false;
      ignoreExclusiveZones = false;
      closeOnClick = true;
    };

    extraCss = ''
      @define-color text #${config.lib.stylix.colors.base05};
      @define-color alt-text #${config.lib.stylix.colors.base04};
      @define-color bg-active #${config.lib.stylix.colors.base01};
      @define-color bg-inactive #${config.lib.stylix.colors.base00};
      @define-color unselected #${config.lib.stylix.colors.base00};
      @define-color selected #${config.lib.stylix.colors.base03};

      * {
        transition: 200ms ease;
        font-family: "${config.stylix.fonts.monospace.name}";
        font-size: 12px;
        font-weight: bold;
      }

      #main,
      #plugin {
        color: @text;
        background-color: @bg-active;
        border: 1px solid @bg-inactive;
        border-radius: 4px;
      }

      #window {
        background-color: rgba(43, 48, 59, 0.5);
      }

      #entry {
        color: @text;
        background-color: @bg-inactive;
        border-radius: 4px;
      }

      #match {
        color: @text;
        background: @unselected;
        padding: 4px;
      }

      #match:selected {
        color: @alt-text;
        background-color: @selected;
      }
    '';
  };
}
