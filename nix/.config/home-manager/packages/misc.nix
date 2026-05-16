{ pkgs, ... }:

{
  home.packages = with pkgs; [
    stow
    gemini-cli
    codex
    nerd-fonts.meslo-lg
  ];
}
