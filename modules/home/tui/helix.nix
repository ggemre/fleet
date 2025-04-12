_: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      keys.normal = {
        j = "move_char_left";
        k = "move_visual_line_down";
        l = "move_visual_line_up";
        ";" = "move_char_right";
        h = "collapse_selection";
        "A-h" = "flip_selections";
        "A-j" = "select_prev_sibling";
        "A-k" = "shrink_selection";
        "A-l" = "expand_selection";
        "A-;" = "select_next_sibling";
        z = {
          k = "scroll_down";
          l = "scroll_up";
        };
        g = {
          j = "goto_line_start";
          ";" = "goto_line_end";
        };
        "C-w" = {
          j = "jump_view_left";
          "C-j" = "jump_view_left";
          k = "jump_view_down";
          "C-k" = "jump_view_down";
          l = "jump_view_up";
          "C-l" = "jump_view_up";
          ";" = "jump_view_right";
          "C-;" = "jump_view_right";
        };
      };
      keys.select = {
        j = "extend_char_left";
        k = "extend_visual_line_down";
        l = "extend_visual_line_up";
        ";" = "extend_char_right";
        h = "collapse_selection";
        "A-h" = "flip_selections";
        "A-j" = "select_prev_sibling";
        "A-k" = "shrink_selection";
        "A-l" = "expand_selection";
        "A-;" = "select_next_sibling";
        z = {
          k = "scroll_down";
          l = "scroll_up";
        };
        g = {
          j = "goto_line_start";
          ";" = "goto_line_end";
        };
        "C-w" = {
          j = "jump_view_left";
          "C-j" = "jump_view_left";
          k = "jump_view_down";
          "C-k" = "jump_view_down";
          l = "jump_view_up";
          "C-l" = "jump_view_up";
          ";" = "jump_view_right";
          "C-;" = "jump_view_right";
        };
      };
      # editor = {
      #   color-modes = true;
      #   cursorline = true;
      #   mouse = true;
      #   scrolloff = 5;
      #   rainbow-brackets = true;
      #   completion-replace = true;
      #   bufferline = "always";
      #   true-color = true;
      #   # rulers = [80];
      #   soft-wrap.enable = false;
      #   indent-guides = {
      #     render = true;
      #   };
      #   sticky-context = {
      #     enable = true;
      #     indicator = true;
      #   };
      #   lsp = {
      #     display-messages = true;
      #     display-inlay-hints = true;
      #   };
      #   gutters = ["diagnostics" "line-numbers" "spacer" "diff"];
      #   statusline = {
      #     mode-separator = "";
      #     separator = "";
      #     left = ["mode" "selections" "spinner" "file-name" "total-line-numbers"];
      #     center = [];
      #     right = ["diagnostics" "file-encoding" "file-line-ending" "file-type" "position-percentage" "position"];
      #     mode = {
      #       normal = "NORMAL";
      #       insert = "INSERT";
      #       select = "SELECT";
      #     };
      #   };

      #   whitespace.characters = {
      #     space = "·";
      #     nbsp = "⍽";
      #     tab = "→";
      #     newline = "⤶";
      #   };

      #   cursor-shape = {
      #     insert = "bar";
      #     normal = "block";
      #     select = "block";
      #   };
      # };
    };
  };
}
