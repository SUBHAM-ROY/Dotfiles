{ lib, pkgs, ... }:

lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
  programs.yt-dlp = {
    enable = true;

    settings = {
      format-sort = "res:1440";
      merge-output-format = "mkv";
      embed-subs = true;
      sub-langs = "en.*";
      embed-thumbnail = true;
      embed-metadata = true;
    };
  };
}
