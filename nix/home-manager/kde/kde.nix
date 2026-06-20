{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    candy-icons
    sweet-nova
  ];

  programs.plasma = {
    enable = true;

    workspace = {
      colorScheme = "Sweet";
      iconTheme = "candy-icons";
      cursor = {
        theme = "Sweet-cursors";
        size = 24;
      };
      windowDecorations = {
        library = "org.kde.kwin.aurorae";
        theme = "__aurorae__svg__Sweet-Dark";
      };
    };

    kwin.virtualDesktops.number = 5;

    shortcuts = {
      kwin = {
        "Window Close" = "Meta+Q";
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
      };
      plasmashell = {
        "activate task manager entry 1" = "Alt+1";
        "activate task manager entry 2" = "Alt+2";
        "activate task manager entry 3" = "Alt+3";
        "activate task manager entry 4" = "Alt+4";
        "activate task manager entry 5" = "Alt+5";
      };
      "services/brave-browser.desktop"._launch = "Alt+Shift+B";
      "services/kitty.desktop"._launch = "Alt+Shift+K";
      "services/obsidian.desktop"._launch = "Alt+Shift+O";
      "services/calibre-gui.desktop"._launch = "Alt+Shift+C";
      "services/spotify.desktop"._launch = "Alt+Shift+M";
      "services/org.kde.dolphin.desktop"._launch = "Alt+Shift+F";
      "services/org.kde.haruna.desktop"._launch = "Alt+Shift+H";
      "services/org.kde.spectacle.desktop"._launch = "Print";
      "services/systemsettings.desktop"._launch = "Alt+.";
      "services/org.kde.krunner.desktop"._launch = [
        "Meta+Space"
        "Search"
      ];
    };

  };
}
