{ lib, pkgs, ... }:

lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
  programs.mpv = {
    enable = true;

    config = {
      profile = "high-quality";
      hwdec = "nvdec";
      save-position-on-quit = true;
      ytdl-format = "bestvideo[height<=1440]+bestaudio/best[height<=1440]";
    };
  };
}
