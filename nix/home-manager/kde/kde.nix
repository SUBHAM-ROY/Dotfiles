{
  lib,
  pkgs,
  ...
}:
lib.mkIf pkgs.stdenv.isLinux {
  home.packages = with pkgs; [
    candy-icons
    kdePackages.krohnkite
    kara
    nordic
  ];

  programs.plasma = {
    enable = false;
    overrideConfig = true;

    workspace = {
      colorScheme = "NordicDarker";
      iconTheme = "candy-icons";
      theme = "default";
      soundTheme = "freedesktop";
      cursor = {
        theme = "Nordic-cursors";
        size = 24;
      };
      windowDecorations = {
        library = "org.kde.kwin.aurorae.v2";
        theme = "__aurorae__svg__Nordic";
      };
    };

    krunner = {
      position = "center";
    };

    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

    kwin.virtualDesktops = {
      number = 5;
      rows = 1;
    };

    powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        turnOffDisplay.idleTimeout = "never";
        dimDisplay.enable = false;
        whenLaptopLidClosed = "doNothing";
      };
    };

    shortcuts = {
      ksmserver."Lock Session" = [
        "Alt+Shift+L"
        "Screensaver"
      ];
      kwin = {
        "Window Close" = "Meta+Q";
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Window to Next Desktop" = "Ctrl+Alt+L";
        "Window to Previous Desktop" = "Ctrl+Alt+H";
        KrohnkiteFloatAll = "Meta+Shift+F";
        KrohnkiteFocusDown = "Meta+J";
        KrohnkiteFocusLeft = "Meta+H";
        KrohnkiteFocusRight = "Meta+L";
        KrohnkiteFocusUp = "Meta+K";
        KrohnkiteIncrease = "Meta+I";
        KrohnkiteMonocleLayout = "Meta+M";
        KrohnkiteNextLayout = "Meta+\\\\";
        KrohnkitePreviousLayout = "Meta+|";
        KrohnkiteRotate = "Meta+]";
        KrohnkiteSetMaster = "Meta+Return";
        KrohnkiteShiftDown = "Meta+Shift+J";
        KrohnkiteShiftLeft = "Meta+Shift+H";
        KrohnkiteShiftRight = "Meta+Shift+L";
        KrohnkiteShiftUp = "Meta+Shift+K";
        KrohnkiteToggleFloat = "Meta+F";
        KrohnkiteGrowHeight = "Meta+Ctrl+J";
        KrohnkitegrowWidth = "Meta+Ctrl+L";
        KrohnkiteShrinkHeight = "Meta+Ctrl+K";
        KrohnkiteShrinkWidth = "Meta+Ctrl+H";
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
      "services/org.kde.discover.desktop".Updates = "Alt+Shift+U";
      "services/org.kde.krunner.desktop"._launch = [
        "Meta+Space"
        "Search"
      ];
    };

    configFile."kwinrc" = {
      Plugins.krohnkiteEnabled = true;
      "Script-krohnkite" = {
        binaryTreeLayoutOrder = 3;
        cascadeLayoutOrder = 0;
        columnsLayoutOrder = 0;
        floatingLayoutOrder = 0;
        monocleLayoutOrder = 1;
        quarterLayoutOrder = 0;
        spiralLayoutOrder = 0;
        spreadLayoutOrder = 0;
        stackedLayoutOrder = 0;
        stairLayoutOrder = 0;
        threeColumnLayoutOrder = 0;
        tileLayoutOrder = 2;
      };
    };

    configFile."kuriikwsfilterrc" = {
      General.DefaultWebShortcut = "google";
      General.KeywordDelimiter = {
        value = "\\s";
        escapeValue = false;
      };
    };

    panels = [
      {
        location = "top";
        height = 32;
        widgets = [
          {
            iconTasks = {
              launchers = [ ];
              appearance.fill = false;
            };
          }
          {
            panelSpacer = {
              expanding = false;
              length = 30;
            };
          }
          "org.kde.plasma.appmenu"
          "org.kde.plasma.panelspacer"
          {
            name = "org.dhruv8sh.kara";
            config = {
              general = {
                type = 0;
                spacing = 7;
              };
              appearance = {
                altColor = "143,188,187";
                defaultAltTextColors = false;
                plasmaTxtColors = false;
                txtColor = "129,161,193";
              };
              type1 = {
                t1activeHeight = 18;
                t1activeWidth = 18;
                t1height = 18;
                t1width = 18;
              };
            };
          }
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          {
            panelSpacer = {
              expanding = false;
              length = 30;
            };
          }
          {
            digitalClock = {
              date.format = "longDate";
              time.showSeconds = "always";
              font = {
                family = "Noto Sans";
                size = 12;
                weight = 600;
              };
            };
          }
        ];
      }
    ];

    desktop = {
      widgets = [
        {
          name = "com.github.prayag2.modernclock";
          position = {
            horizontal = 1424;
            vertical = 16;
          };
          size = {
            width = 448;
            height = 256;
          };
        }
        {
          systemMonitor = {
            position = {
              horizontal = 1376;
              vertical = 288;
            };
            size = {
              width = 272;
              height = 240;
            };
            displayStyle = "org.kde.ksysguard.linechart";
            showTitle = false;
            sensors = [
              {
                name = "cpu/all/usage";
                color = "207,0,0";
                label = "CPU Usage";
              }
            ];
            textOnlySensors = [ "cpu/all/averageTemperature" ];
            settings = {
              Sensors.highPrioritySensorIds = "[\"cpu/all/usage\"]";
              Sensors.lowPrioritySensorIds = "[\"cpu/all/averageTemperature\"]";
              Appearance.updateRateLimit = 1000;
              SensorColors."cpu/all/averageTemperature" = "100,0,0";
              SensorLabels."cpu/all/averageTemperature" = "CPU Temp";
            };
          };
        }
        {
          systemMonitor = {
            position = {
              horizontal = 1648;
              vertical = 288;
            };
            size = {
              width = 272;
              height = 240;
            };
            displayStyle = "org.kde.ksysguard.linechart";
            showTitle = false;
            sensors = [
              {
                name = "gpu/all/usage";
                color = "0,0,255";
                label = "GPU Usage";
              }
            ];
            textOnlySensors = [ "gpu/gpu0/temperature" ];
            settings = {
              Sensors.highPrioritySensorIds = "[\"gpu/all/usage\"]";
              Sensors.lowPrioritySensorIds = "[\"gpu/gpu0/temperature\"]";
              Appearance.updateRateLimit = 1000;
              SensorColors."gpu/gpu0/temperature" = "95,76,28";
              SensorLabels."gpu/gpu0/temperature" = "GPU Temp";
            };
          };
        }
        {
          systemMonitor = {
            position = {
              horizontal = 1376;
              vertical = 512;
            };
            size = {
              width = 272;
              height = 240;
            };
            displayStyle = "org.kde.ksysguard.piechart";
            showTitle = true;
            title = "Disk Usage";
            sensors = [
              {
                name = "disk/f57a50c1-7903-4f68-91c6-dedcad22a611/free";
                color = "0,66,0";
                label = "Free";
              }
              {
                name = "disk/f57a50c1-7903-4f68-91c6-dedcad22a611/used";
                color = "85,0,0";
                label = "Used";
              }
            ];
            totalSensors = [ "disk/f57a50c1-7903-4f68-91c6-dedcad22a611/total" ];
            settings = {
              Sensors.highPrioritySensorIds = "[\"disk/f57a50c1-7903-4f68-91c6-dedcad22a611/free\", \"disk/f57a50c1-7903-4f68-91c6-dedcad22a611/used\"]";
              Sensors.totalSensors = "[\"disk/f57a50c1-7903-4f68-91c6-dedcad22a611/total\"]";
              Appearance.updateRateLimit = 3000;
              SensorLabels."disk/f57a50c1-7903-4f68-91c6-dedcad22a611/freePercent" = "Free %";
              SensorLabels."disk/f57a50c1-7903-4f68-91c6-dedcad22a611/usedPercent" = "Used %";
              SensorLabels."disk/f57a50c1-7903-4f68-91c6-dedcad22a611/total" = "Total";
              SensorLabels."disk/nvme0n1/total" = "Total";
            };
          };
        }
        {
          systemMonitor = {
            position = {
              horizontal = 1648;
              vertical = 512;
            };
            size = {
              width = 272;
              height = 240;
            };
            displayStyle = "org.kde.ksysguard.textonly";
            showTitle = true;
            title = "Battery Stats";
            sensors = [
              {
                name = "power/battery_BAT1/chargePercentage";
                color = "49,151,167";
                label = "Charge";
              }
              {
                name = "power/battery_BAT1/capacity";
                color = "95,92,28";
                label = "Current Cap";
              }
              {
                name = "power/battery_BAT1/design";
                color = "39,118,0";
                label = "Design Cap";
              }
              {
                name = "power/battery_BAT1/health";
                color = "95,46,28";
                label = "Health";
              }
              {
                name = "power/battery_BAT1/chargeRate";
                color = "28,57,95";
                label = "Rate";
              }
            ];
            settings = {
              Sensors.highPrioritySensorIds = "[\"power/battery_BAT1/chargePercentage\", \"power/battery_BAT1/capacity\", \"power/battery_BAT1/design\", \"power/battery_BAT1/health\", \"power/battery_BAT1/chargeRate\"]";
              Appearance.updateRateLimit = 3000;
            };
          };
        }
        {
          systemMonitor = {
            position = {
              horizontal = 1376;
              vertical = 752;
            };
            size = {
              width = 272;
              height = 240;
            };
            displayStyle = "org.kde.ksysguard.linechart";
            showTitle = false;
            sensors = [
              {
                name = "memory/physical/used";
                color = "248,161,0";
                label = "RAM Usage";
              }
            ];
            textOnlySensors = [
              "memory/physical/total"
              "memory/physical/usedPercent"
            ];
            settings = {
              Sensors.highPrioritySensorIds = "[\"memory/physical/used\"]";
              Sensors.lowPrioritySensorIds = "[\"memory/physical/total\", \"memory/physical/usedPercent\"]";
              SensorColors."memory/physical/total" = "95,28,79";
              SensorColors."memory/physical/usedPercent" = "28,95,79";
              SensorLabels."memory/physical/total" = "RAM Size";
              SensorLabels."memory/physical/usedPercent" = "RAM %";
            };
          };
        }
        {
          systemMonitor = {
            position = {
              horizontal = 1648;
              vertical = 752;
            };
            size = {
              width = 272;
              height = 240;
            };
            displayStyle = "org.kde.ksysguard.linechart";
            showTitle = false;
            sensors = [
              {
                name = "network/wlo1/download";
                color = "123,123,185";
                label = "Downstream";
              }
              {
                name = "network/wlo1/upload";
                color = "213,204,101";
                label = "Upstream";
              }
            ];
            textOnlySensors = [
              "network/wlo1/signal"
              "network/wlo1/ipv4address"
            ];
            settings = {
              Sensors.highPrioritySensorIds = "[\"network/wlo1/download\", \"network/wlo1/upload\"]";
              Sensors.lowPrioritySensorIds = "[\"network/wlo1/signal\", \"network/wlo1/ipv4address\"]";
              Appearance.updateRateLimit = 1000;
              SensorLabels."network/wlo1/signal" = "Signal";
              SensorLabels."network/wlo1/ipv4address" = "IPv4";
            };
          };
        }
      ];
    };

  };
}
