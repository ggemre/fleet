{
  config,
  pkgs,
  ...
}: {
  programs.zed-editor = {
    package = pkgs.zed-editor-fhs; # FHS-compliant for LSPs
    enable = true;
    extensions = [
      "nix"
    ];
    extraPackages = with pkgs; [
      nixd
      nil
      alejandra
    ];

    userSettings = {
      vim_mode = true;
      relative_line_numbers = true;
      features.copilot = false;
      dock = "right";
      project_panel = {
        button = true;
        default_width = 240;
        dock = "left";
        entry_spacing = "comfortable";
      };
      assistant = {
        enabled = false;
        button = false;
        dock = "left";
      };
      outline_panel = {
        button = false;
        default_width = 300;
        dock = "left";
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      languages = {
        Nix = {
          formatter.command = "alejandra";
          language_servers = ["nixd" "nil" "..."];
        };
      };
      lsp = {
        nixd.settings.diagnostic.suppress = ["sema-extra-with"];
        nil.settings.formatting.command = ["nixfmt"];
      };
    };
  };
}
