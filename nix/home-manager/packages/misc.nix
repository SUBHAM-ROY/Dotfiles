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
      gemini-cli
      codex
      opencode
      brave
      yt-dlp
      calibre
      spotify
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      cursor-cli
      gh
      jira-cli-go
    ];
}
