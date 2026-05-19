{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
  ];

  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nix/home-manager/neovim/config";
}
