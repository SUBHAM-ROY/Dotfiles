{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    mouse = true;
    shell = "${pkgs.fish}/bin/fish";
    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_status_style "rounded"
          set -g @catppuccin_window_text " #{window_name}"
          set -g @catppuccin_window_current_text " #{window_name}"

          set -g status-right-length 100
          set -g status-left-length 100

          set -g status-left "#{E:@catppuccin_status_session}"

          set -g status-right "#{E:@catppuccin_status_date_time}"
          set -ag status-right "#{E:@catppuccin_status_application}"
          set -ag status-right "#{E:@catppuccin_status_directory}"
        '';
      }
      resurrect
    ];

    extraConfig = ''
      # General
      set -g renumber-windows on
      set -g status-position top
      set -g allow-passthrough on

      unbind x
      bind x kill-pane
      unbind \;
      bind \; command-prompt -p "Rename session:" -I '#S' "rename-session '%%'"
      bind X kill-session
      bind N new-session
      bind \\ split-window -h
      bind - split-window -v
      bind S-Left swap-window -dt -1
      bind S-Right swap-window -dt +1
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind H swap-pane -U
      bind L swap-pane -D
      bind -r C-h resize-pane -L 5
      bind -r C-j resize-pane -D 5
      bind -r C-k resize-pane -U 5
      bind -r C-l resize-pane -R 5
    '';
  };
}
