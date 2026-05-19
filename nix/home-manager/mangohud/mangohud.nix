{
  lib,
  pkgs,
  ...
}:

{
  programs.mangohud = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    settings = {
      fps_limit = "60,90";
      fps_limit_method = "late";
      gpu_temp = true;
      cpu_temp = true;
      frametime = 0;
      horizontal = true;
      gpu_list = 1;
      frame_timing = 0;
      background_alpha = "0";
    };
  };
}
