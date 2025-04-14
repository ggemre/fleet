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
      * {
        transition: 200ms ease;
        font-family: "${config.stylix.fonts.monospace.name}";
        font-size: 12px;
        font-weight: bold;
      }

      #main,
      #plugin {
        color: #${config.lib.stylix.colors.base05};
        background-color: #${config.lib.stylix.colors.base01};
        margin: 0;
        padding: 0;
        border: none;
      }

      #window {
        background-color: rgba(43, 48, 59, 0.5);
      }

      #entry {
        color: #${config.lib.stylix.colors.base05};
        background-color: #${config.lib.stylix.colors.base00};
        border-radius: 4px;
        border: 1px solid #${config.lib.stylix.colors.base04};
      }

      #match {
        color: #${config.lib.stylix.colors.base05};
        background-color: #${config.lib.stylix.colors.base00};
        padding: 2px;
      }

      #match:selected {
        color: #${config.lib.stylix.colors.base0F};
        background-color: #${config.lib.stylix.colors.base07};
        border-radius: 4px;
      }
    '';
  };
}
