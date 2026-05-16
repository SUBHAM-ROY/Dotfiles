{ pkgs, lib, ... }:

{
  home.packages =
    with pkgs;
    [
      stow
      gemini-cli
      codex
      nerd-fonts.meslo-lg
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      obsidian
      brave
      yt-dlp
      stremio-linux-shell
      albert
    ];
}
