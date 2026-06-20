{ pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isLinux {
  home.packages = [ pkgs.haruna ];

  xdg.configFile."haruna/custom-commands.conf".text = ''
    Counter=5

    [Command_0]
    Command=Show Time
    Order=0
    OsdMessage=Time: ''${time-pos}  Remaining: ''${time-remaining}
    Type=shortcut

    [Command_1]
    Command=Show Name
    Order=1
    OsdMessage=''${media-title}
    Type=shortcut

    [Command_2]
    Command=add audio-delay 0.1
    Order=2
    OsdMessage=Audio Delay: ''${audio-delay}
    Type=shortcut

    [Command_3]
    Command=add audio-delay -0.1
    Order=3
    OsdMessage=Audio Delay: ''${audio-delay}
    Type=shortcut
  '';

  xdg.configFile."haruna/shortcuts.conf".text = ''
    [Shortcuts]
    Command_0=T
    Command_1=N
    Command_2==
    Command_3=-
  '';
}

