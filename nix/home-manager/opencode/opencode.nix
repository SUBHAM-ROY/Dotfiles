{ pkgs, lib, ... }:

{
  programs.opencode = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    settings = {
      permission = {
        bash = "ask";
        edit = "ask";
      };
    };
  };
}
