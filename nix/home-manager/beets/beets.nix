{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf pkgs.stdenv.isLinux {
  programs.beets = {
    enable = true;
    settings = {
      directory = "/srv/music";
      plugins = [
        "fish"
        "musicbrainz"
        "info"
        "lastgenre"
        "lyrics"
        "duplicates"
        "edit"
      ];
      import = {
        move = true;
        duplicate_action = "merge";
        group_albums = true;
      };
      lastgenre = {
        force = true;
      };
      lyrics = {
        synced = true;
        sources = [ "lrclib" ];
      };
    };
  };
}

