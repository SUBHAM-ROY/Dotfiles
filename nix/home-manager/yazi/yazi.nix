{ pkgs, ... }:

let
  yaziFlavors = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "flavors";
    rev = "36c49acfd7d3924bd751fd74e37b6ff438af691a";
    sha256 = "sha256-IK0Ye/EPjOGC+//HpjExVTAKfXtlgOrYbFLrhy/DF6k=";
  };
in
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
    flavors = {
      catppuccin-mocha = "${yaziFlavors}/catppuccin-mocha.yazi";
    };
    theme = {
      flavor = {
        dark = "catppuccin-mocha";
      };
    };
  };
}
