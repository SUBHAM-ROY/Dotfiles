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
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      keepassxc
      iptvnator
      brave
      calibre
      spotify
      feishin
      kew
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
      cursor-cli
      jira-cli-go
      claude-code
    ];
}
