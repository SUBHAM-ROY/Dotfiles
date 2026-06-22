{ ... }:

let
  esc = builtins.fromJSON ''"\u001b"'';
in
{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        source = "$HOME/Downloads/logo.png";
        type = "kitty-icat";
        height = 25;
        width = 50;
        padding = {
          top = 5;
          left = 2;
        };
      };

      modules = [
        "break"

        {
          type = "custom";
          format = "${esc}[31m════════════════════ System Info ═════════════════════";
        }
        {
          type = "host";
          key = "  PC";
          keyColor = "red";
        }
        {
          type = "cpu";
          key = " CPU";
          showPeCoreCount = true;
          keyColor = "red";
        }
        {
          type = "gpu";
          format = "{vendor} {name} [{driver}]";
          key = " GPU";
          keyColor = "red";
        }
        {
          type = "display";
          key = "󰹑 DISPLAY";
          keyColor = "red";
        }
        {
          type = "sound";
          key = "󰓃 SOUND";
          keyColor = "red";
        }
        {
          type = "memory";
          key = "󰍛 MEMORY";
          keyColor = "red";
        }
        {
          type = "swap";
          key = "󰓡 SWAP";
          keyColor = "red";
        }
        {
          type = "custom";
          format = "${esc}[31m══════════════════════════════════════════════════════";
        }

        "break"

        {
          type = "custom";
          format = "${esc}[32m═══════════════════════ Drives ═══════════════════════";
        }
        {
          type = "disk";
          key = " DISK";
          keyColor = "green";
        }
        {
          type = "custom";
          format = "${esc}[32m══════════════════════════════════════════════════════";
        }

        "break"

        {
          type = "custom";
          format = "${esc}[33m═════════════════════════ OS ═════════════════════════";
        }
        {
          type = "os";
          key = " OS";
          keyColor = "yellow";
        }
        {
          type = "kernel";
          key = " KERNEL";
          keyColor = "yellow";
        }
        {
          type = "packages";
          key = "󰏖 PACKAGES";
          keyColor = "yellow";
        }
        {
          type = "terminal";
          key = " TERMINAL";
          keyColor = "yellow";
        }
        {
          type = "terminalfont";
          key = "󰛖 TERMINAL FONT";
          keyColor = "yellow";
        }
        {
          type = "shell";
          key = " SHELL";
          keyColor = "yellow";
        }
        {
          type = "custom";
          format = "${esc}[33m══════════════════════════════════════════════════════";
        }

        "break"

        {
          type = "custom";
          format = "${esc}[34m════════════════ Desktop Environment ═════════════════";
        }
        {
          type = "de";
          key = " DE";
          keyColor = "blue";
        }
        {
          type = "lm";
          key = " DISPLAY MANAGER";
          keyColor = "blue";
        }
        {
          type = "wm";
          key = " WINDOW MANAGER";
          keyColor = "blue";
        }
        {
          type = "wmtheme";
          key = " THEME";
          keyColor = "blue";
        }
        {
          type = "icons";
          key = "󰉼 ICONS";
          keyColor = "blue";
        }
        {
          type = "font";
          key = "󰛖 SYSTEM FONT";
          format = "{3}";
          keyColor = "blue";
        }
        {
          type = "custom";
          format = "${esc}[34m══════════════════════════════════════════════════════";
        }

        "break"

        {
          type = "custom";
          format = "${esc}[35m════════════════════ Age / Uptime ════════════════════";
        }
        {
          type = "command";
          key = "󰔟 OS Age";
          keyColor = "magenta";
          text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
        }
        {
          type = "uptime";
          key = "󱎫 Uptime";
          keyColor = "magenta";
        }
        {
          type = "custom";
          format = "${esc}[35m══════════════════════════════════════════════════════";
        }
      ];
    };
  };
}
