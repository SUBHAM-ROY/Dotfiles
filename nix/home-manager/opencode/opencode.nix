{ pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isLinux {
  programs.opencode = {
    enable = true;
    settings = {
      permission = {
        bash = "ask";
        edit = "ask";
      };
    };
  };
}
