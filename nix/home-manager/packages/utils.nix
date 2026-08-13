{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tldr
    speedtest-cli
    bat
    ouch
    unrar
    lsd
    jq
    fd
    dust
    delta
    borgbackup
  ];
}
