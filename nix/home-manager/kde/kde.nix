{
  lib,
  pkgs,
  config,
  ...
}:

let
  kdeDir = "${config.home.homeDirectory}/dotfiles/nix/home-manager/kde";
  link = path: config.lib.file.mkOutOfStoreSymlink "${kdeDir}/${path}";
in
{
  # KDE Plasma is Linux-only. Plasma Manager has been painful in the past, so
  # for now we just symlink the raw config files out of the store.
  home.file = lib.mkIf pkgs.stdenv.isLinux {
    ".config/kcminputrc".source = link "kcminputrc";
    ".config/kdeglobals".source = link "kdeglobals";
    ".config/kglobalshortcutsrc".source = link "kglobalshortcutsrc";
    ".config/kscreenlockerrc".source = link "kscreenlockerrc";
    ".config/ksplashrc".source = link "ksplashrc";
    ".config/kwinrc".source = link "kwinrc";
    ".config/kwinrulesrc".source = link "kwinrulesrc";
    ".config/plasma-org.kde.plasma.desktop-appletsrc".source = link "plasma-org.kde.plasma.desktop-appletsrc";
    ".config/plasmarc".source = link "plasmarc";
    ".config/plasmashellrc".source = link "plasmashellrc";

    "Downloads/office-lofi.jpg".source = link "office-lofi.jpg";
  };
}
