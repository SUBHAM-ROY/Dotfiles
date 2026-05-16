{ lib, pkgs, ... }:

{
  programs.aerospace = lib.mkIf pkgs.stdenv.isDarwin {
    enable = true;

    settings = {
      after-startup-command = [
        "workspace 1"
        "move-workspace-to-monitor 2"
        "layout accordion"
        "workspace 2"
        "move-workspace-to-monitor 2"
        "layout accordion"
        "workspace 3"
        "move-workspace-to-monitor 2"
        "layout accordion"
        "workspace 4"
        "move-workspace-to-monitor 1"
        "layout accordion"
        "workspace 5"
        "move-workspace-to-monitor 1"
        "layout accordion"
        "workspace 6"
        "move-workspace-to-monitor 1"
        "layout accordion"
      ];

      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      accordion-padding = 0;

      default-root-container-layout = "accordion";
      default-root-container-orientation = "auto";

      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];

      automatically-unhide-macos-hidden-apps = false;

      key-mapping.preset = "qwerty";

      gaps = {
        inner.horizontal = 8;
        inner.vertical = 8;
        outer.left = 0;
        outer.bottom = 0;
        outer.top = 0;
        outer.right = 0;
      };

      mode.main.binding = {
        ctrl-alt-k = ''exec-and-forget osascript -e 'tell application "Kitty" to activate' '';
        ctrl-alt-e = ''exec-and-forget osascript -e 'tell application "Microsoft Edge" to activate' '';
        ctrl-alt-o = ''exec-and-forget osascript -e 'tell application "Obsidian" to activate' '';
        ctrl-alt-s = ''exec-and-forget osascript -e 'tell application "Slack" to activate' '';
        ctrl-alt-m = ''exec-and-forget osascript -e 'tell application "Microsoft Outlook" to activate' '';
        ctrl-alt-enter = "exec-and-forget open -na 'Kitty'";

        ctrl-alt-up = "fullscreen --no-outer-gaps";

        alt-shift-backslash = "layout tiles horizontal vertical";
        alt-backslash = "layout tiles accordion";

        alt-backtick = "focus dfs-next --boundaries-action wrap-around-the-workspace";
        alt-shift-backtick = "focus-monitor --wrap-around next";

        alt-shift-h = "move left --boundaries-action stop";
        alt-shift-j = "move down --boundaries-action stop";
        alt-shift-k = "move up --boundaries-action stop";
        alt-shift-l = "move right --boundaries-action stop";

        alt-minus = "resize smart -50";
        alt-equal = "resize smart +50";
        alt-shift-minus = "resize smart-opposite -50";
        alt-shift-equal = "resize smart-opposite +50";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";

        alt-shift-1 = [
          "move-node-to-workspace 1"
          "workspace 1"
        ];
        alt-shift-2 = [
          "move-node-to-workspace 2"
          "workspace 2"
        ];
        alt-shift-3 = [
          "move-node-to-workspace 3"
          "workspace 3"
        ];
        alt-shift-4 = [
          "move-node-to-workspace 4"
          "workspace 4"
        ];
        alt-shift-5 = [
          "move-node-to-workspace 5"
          "workspace 5"
        ];
        alt-shift-6 = [
          "move-node-to-workspace 6"
          "workspace 6"
        ];

        ctrl-alt-h = "move-node-to-monitor --focus-follows-window --wrap-around left";
        ctrl-alt-l = "move-node-to-monitor --focus-follows-window --wrap-around right";

        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

        alt-shift-f = "layout floating tiling";

        alt-semicolon = "mode service";
      };

      mode.service.binding = {
        r = [
          "reload-config"
          "mode main"
        ];
        esc = [
          "flatten-workspace-tree"
          "mode main"
        ];
        backspace = [
          "close-all-windows-but-current"
          "mode main"
        ];

        alt-shift-h = [
          "join-with left"
          "mode main"
        ];
        alt-shift-j = [
          "join-with down"
          "mode main"
        ];
        alt-shift-k = [
          "join-with up"
          "mode main"
        ];
        alt-shift-l = [
          "join-with right"
          "mode main"
        ];
      };

      on-window-detected = [
        {
          "if".app-name-regex-substring = "zoom";
          run = [ "move-node-to-workspace 5" ];
        }
        {
          "if".app-name-regex-substring = "slack";
          run = [ "move-node-to-workspace 3" ];
        }
        {
          "if".app-name-regex-substring = "outlook";
          run = [ "move-node-to-workspace 4" ];
        }
        {
          "if".app-name-regex-substring = "kitty|cursor|code";
          run = [ "move-node-to-workspace 2" ];
        }
        {
          "if".app-name-regex-substring = "edge";
          run = [ "move-node-to-workspace 1" ];
        }
      ];
    };
  };
}
