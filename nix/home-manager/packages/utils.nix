{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    borgbackup
    delta
    dust
    fd
    file
    jq
    lsd
    ouch
    speedtest-cli
    tldr
    unrar
  ];
}
