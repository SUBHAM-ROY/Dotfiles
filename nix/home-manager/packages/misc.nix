{
  pkgs,
  lib,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      nerd-fonts.meslo-lg
      obsidian
      gh
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      keepassxc
      iptvnator
      wineWow64Packages.stagingFull
      brave
      calibre
      spotify
      feishin
      kew
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      cursor-cli
      jira-cli-go
      claude-code
    ];
}
