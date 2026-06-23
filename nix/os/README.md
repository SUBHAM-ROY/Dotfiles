# NixOS Setup Guide

## 1. Fresh Install (from GitHub)

```bash
# Install NixOS with KDE Plasma 6. Flakes aren't enabled yet, so use the env var:
sudo NIX_CONFIG="experimental-features = nix-command flakes" \
  nixos-rebuild switch --flake github:SUBHAM-ROY/Dotfiles/nix/os#roynix

# Install home-manager config directly from GitHub
nix run github:nix-community/home-manager -- switch --flake github:SUBHAM-ROY/Dotfiles/nix/home-manager#sroy
```

## 2. Clone dotfiles locally

```bash
git clone https://github.com/SUBHAM-ROY/Dotfiles ~/dotfiles
```

From now on (flakes are already enabled by the first rebuild), use `nh` for rebuilds:

```bash
nh os switch
nh home switch
```

## 3. Install external KDE plugins

Everything from `kde.nix` packages (`candy-icons`, `nordic`, `kdePackages.krohnkite`, `kara`)
is already handled by Nix. Manually install from KDE Store:

- **Modern Clock** desktop widget (`com.github.prayag2.modernclock`)
- **Panel Colorizer** (`luisbocanegra.panel.colorizer`, see step 5)

## 4. Apply plasma-manager config once

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

## 5. Colorizer

Install **Panel Colorizer** (`luisbocanegra.panel.colorizer`) from KDE Store. Copy the preset folder to `~/.config/colorizer/` and set it in Panel Colorizer settings.

## 6. Post-setup

Set wallpaper in System Settings → Appearance → Wallpaper, and lockscreen image in System Settings → Screen Locking → Appearance (both use `astronaut.png` in `nix/home-manager/kde/wallpapers/`).

## Now enjoy your pretty NixOS! ❄️🎉
