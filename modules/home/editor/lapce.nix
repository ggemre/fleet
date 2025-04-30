{
  pkgs,
  config,
  ...
}: {
  programs.lapce = {
    enable = true;
    settings = {
      editor = {
        font-family = config.stylix.fonts.monospace.name;
        font-size = 14;
        tab-width = 2;
        cursor-surrounding-lines = 4;
        render-whitespace = "all";
        bracket-pair-colorization = true;
        highlight-matching-brackets = true;
      };
      ui = {
        font-size = 12;
        open-editors-visible = false;
      };
      lapce-nix.lsp-path = "${pkgs.nil}/bin/nil";
      lapce-markdown.serverPath = "${pkgs.marksman}/bin/marksman";
    };
    plugins = [
      {
        author = "MrFoxPro";
        name = "lapce-nix";
        version = "0.0.1";
        hash = "sha256-n+j8p6sB/Bxdp0iY6Gty9Zkpv9Rg34HjKsT1gUuGDzQ=";
      }
      {
        author = "zarathir";
        name = "lapce-markdown";
        version = "0.3.2";
        hash = "sha256-+fn9enUr9y663m/3xloFau1yuJ34GDHDVWmOwYrSAbY=";
      }
    ];
  };
}
