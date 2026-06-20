{ pkgs, lib, ... }:

{
  home.packages =
    with pkgs;
    [
      stow
      nerd-fonts.meslo-lg
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      obsidian
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
      gh
      jira-cli-go
    ];
}
