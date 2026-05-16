{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tldr
    speedtest-cli
    bat
    ouch
    lsd
    jq
    fd
    dust
  ];
}
