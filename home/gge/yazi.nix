_: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      manager = {
        # layout = [1 4 3];
        sort_by = "alphabetical";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = true;
        show_symlink = true;
      };

      # preview = {
      #   tab_size = 2;
      #   max_width = 600;
      #   max_height = 900;
      # };
    };
    keymap = {
      manager.prepend_keymap = [
        { on = [ "j" ]; run = "leave"; }
        { on = [ ";" ]; run = "enter"; }
        { on = [ "J" ]; run = "back"; }
        { on = [ ":" ]; run = "forward"; }
        { on = [ "l" ]; run = "arrow -1"; }
        { on = [ "k" ]; run = "arrow 1"; }
      ];
      spot.prepend_kaymap = [
        { on = [ "j" ]; run = "swipe -1"; }
        { on = [ ";" ]; run = "swipe 1"; }
        { on = [ "l" ]; run = "arrow -1"; }
        { on = [ "k" ]; run = "arrow 1"; }
      ];
      tasks.prepend_kaymap = [
        { on = [ "j" ]; run = "arrow -1"; }
        { on = [ ";" ]; run = "arrow 1"; }
      ];
      input.prepend_kaymap = [
        { on = [ "j" ]; run = "move -1"; }
        { on = [ ";" ]; run = "move 1"; }
      ];
      confirm.prepend_kaymap = [
        { on = [ "l" ]; run = "arrow -1"; }
        { on = [ "k" ]; run = "arrow 1"; }
      ];
      cmp.prepend_kaymap = [
        { on = [ "A-l" ]; run = "arrow -1"; }
        { on = [ "A-k" ]; run = "arrow 1"; }
      ];
      help.prepend_kaymap = [
        { on = [ "l" ]; run = "arrow -1"; }
        { on = [ "k" ]; run = "arrow 1"; }
      ];
    };
  };
}
