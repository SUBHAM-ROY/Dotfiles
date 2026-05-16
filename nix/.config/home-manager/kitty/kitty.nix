{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration = {
      enableFishIntegration = true;
    };
    themeFile = "everforest_dark_hard";
    font = {
      name = "MesloLGS Nerd Font Mono";
      size = 12.0;
    };

    settings = {
      os_window_state = "maximized";
      hide_window_decorations = "titlebar-and-corners";
      confirm_os_window_close = 0;
      mouse_hide_wait = -1.0;
      background_opacity = 0.97;
      background_blur = 0;
      shell = "${pkgs.fish}/bin/fish --login --interactive";
      macos_option_as_alt = "yes";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      enable_audio_bell = false;
      scrollback_lines = 10000;
    };

    keybindings = {
      "ctrl+shift+f" = "toggle_maximized";
    };
  };
}
