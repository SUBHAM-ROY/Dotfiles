{ ... }:

{
  # Enable btop and set some settings.
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "everforest-dark-hard";
      proc_left = true;
      proc_tree = true;
      proc_aggregate = true;
      proc_gradient = false;
      cpu_bottom = true;
    };
  };
}
