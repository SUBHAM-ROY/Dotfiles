{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tldr
    speedtest-cli
    bat
    (ouch.override { enableUnfree = true; })
    lsd
    jq
    fd
    dust
    delta
  ];
}
