{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tldr
    speedtest-cli
    bat
    ouch-rar
    lsd
    jq
    fd
    dust
    delta
    borgbackup
    lazydocker
  ];
}
