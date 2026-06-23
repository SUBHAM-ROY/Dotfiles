# NixOS Setup Guide

## 1. Install NixOS

Install NixOS normally. The installer generates a machine-specific
`/etc/nixos/hardware-configuration.nix` and a stock `/etc/nixos/configuration.nix`
(the repo's flake replaces the latter; only the hardware file is reused — see step 3).

## 2. Clone dotfiles locally

git isn't in the base system yet, so grab it with a throwaway shell:

```bash
nix-shell -p git --run "git clone https://github.com/SUBHAM-ROY/Dotfiles ~/dotfiles"
```

## 3. Use this machine's hardware config

The repo's `hardware-configuration.nix` is specific to my machine. Replace it with the one
the installer generated for this box:

```bash
cp /etc/nixos/hardware-configuration.nix ~/dotfiles/nix/os/hardware-configuration.nix
```

## 4. First rebuild (from the local clone)

```bash
# Flakes aren't enabled yet, so pass the experimental features for this first rebuild:
sudo NIX_CONFIG="experimental-features = nix-command flakes" \
  nixos-rebuild switch --flake ~/dotfiles/nix/os#roynix
nix run github:nix-community/home-manager -- switch --flake ~/dotfiles/nix/home-manager#sroy
```

Flakes are now enabled, so from here on use `nh`:

```bash
nh os switch
nh home switch
```

## 5. Install external KDE plugins

Everything from `kde.nix` packages (`candy-icons`, `nordic`, `kdePackages.krohnkite`, `kara`)
is already handled by Nix. Manually install from KDE Store:

- **Modern Clock** desktop widget (`com.github.prayag2.modernclock`)
- **Panel Colorizer** (`luisbocanegra.panel.colorizer`, see step 7)

## 6. Apply plasma-manager config once

In `nix/home-manager/kde/kde.nix`:

```nix
programs.plasma = {
  enable = true;   # flip from false to true
  overrideConfig = true;
  ...
};
```

```bash
nh home switch
```

After it applies, flip back to `enable = false` so subsequent rebuilds don't reset manual KDE tweaks:

```bash
# Optional: reload plasma shell without logout
reload-plasma
```

## 7. Colorizer

Install **Panel Colorizer** (`luisbocanegra.panel.colorizer`) from KDE Store and run it once
(so it creates `~/.config/panel-colorizer/presets/`), then symlink the Nord preset into it:

```bash
ln -s ~/dotfiles/nix/home-manager/kde/panel-colorizer/presets/Nord-Colorizer ~/.config/panel-colorizer/presets/Nord-Colorizer
```

Load **Nord-Colorizer** in the widget's Presets settings.

## 8. Post-setup

Set wallpaper in System Settings → Appearance → Wallpaper, and lockscreen image in System Settings → Screen Locking → Appearance (both use `astronaut.png` in `nix/home-manager/kde/wallpapers/`).

## Now enjoy your pretty NixOS! ❄️🎉
