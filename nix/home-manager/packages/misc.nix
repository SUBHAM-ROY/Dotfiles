{ pkgs, lib, ... }:

{
  home.packages =
    with pkgs;
    [
      nerd-fonts.meslo-lg
      obsidian
      keepassxc
      gh
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      wineWow64Packages.stagingFull
      codex
      brave
      yt-dlp
      calibre
      spotify
      feishin
      kew
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      cursor-cli
      jira-cli-go
    ];
}
