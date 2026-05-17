{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    gcc
  ];

  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nix/.config/home-manager/neovim/config";
}
