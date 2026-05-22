{ ... }:

{
  # yazi and some settings
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    enableFishIntegration = true;
    settings = {
      mgr = {
        show_hidden = true;
        sort_by = "size";
        linemode = "size";
        sort_reverse = true;
      };
      preview = {
        max_width = 1920;
        max_height = 1080;
        image_quality = 90;
      };
    };
    theme = {
      flavor = {
        dark = "catppuccin-mocha";
      };
    };
  };
}
