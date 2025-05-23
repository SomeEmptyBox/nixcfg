{
  pkgs,
  inputs,
  ...
}:

{
  programs.yazi = {

    enable = true;
    package = pkgs.yazi;

    settings = {
      manager = {
        ratio = [
          3
          4
          3
        ];
        sort_by = "natural";
        show_hidden = false;
        show_symlink = true;
      };

      preview = {
        wrap = "yes";
        image_quality = 50;
      };
    };

    plugins = {
      chmod = "${inputs.yazi-plugins}/chmod.yazi";
      full-border = "${inputs.yazi-plugins}/full-border.yazi";
      toggle-pane = "${inputs.yazi-plugins}/toggle-pane.yazi";
    };

    initLua = ''
      require("full-border"):setup()
    '';

    keymap = {
      manager.prepend_keymap = [
        {
          on = "P";
          run = "plugin toggle-pane max-preview";
          desc = "Maximize or restore the preview pane";
        }
        {
          on = [
            "c"
            "m"
          ];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }
      ];
    };

  };
}
