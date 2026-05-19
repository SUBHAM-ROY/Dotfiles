#!/bin/bash

# Exit on error
set -e

echo "Starting Fedora restoration script..."

# Helper function for confirmation
confirm() {
    while true; do
        read -p "$1? (y/n): " response
        case "$response" in
            y) return 0 ;;
            n) return 1 ;;
            *) echo "Please enter 'y' or 'n'." ;;
        esac
    done
}

# Helper function to run a command with confirmation
run_confirm() {
    if confirm "Run '$*'"; then
        "$@"
    fi
}

# 1. Update system
echo "--- Updating system ---"
run_confirm sudo dnf -y upgrade

# 2. Add Repositories
echo "--- Adding Repositories ---"
run_confirm sudo dnf install -y dnf-plugins-core
run_confirm sudo dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
run_confirm sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
run_confirm flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# 3. Install NVIDIA Drivers
echo "--- Installing NVIDIA Drivers ---"
run_confirm sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda libva-nvidia-driver intel-media-driver

# 4. Multimedia Codecs
echo "--- Multimedia Codecs ---"
run_confirm sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
run_confirm sudo dnf update -y @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

# 5.1. Remove Bloat
echo "--- Removing Bloat ---"
run_confirm sudo dnf remove -y \
    libreoffice* \
    firefox \
    neochat \
    elisa \
    dragon \
    kmail \
    kontact \
    korganizer \
    kaddressbook \
    kmahjongg \
    kmines \
    kpat \
    kolourpaint \
    kmouth \
    skanpage \
    plasma-welcome

# 5.2. Install minimal DNF Packages (system-level only; user tools come from Nix)
echo "--- Installing DNF Packages ---"
run_confirm sudo dnf install -y \
    snapper \
    samba \
    wine \
    keepassxc

run_confirm sudo dnf group install -y development-tools

# 6. Install Nix (Fedora's built-in nix, multi-user / daemon mode)
# See https://fedoraproject.org/wiki/Changes/Nix_package_tool
echo "--- Installing Nix ---"
if ! command -v nix >/dev/null 2>&1; then
    run_confirm sudo dnf install -y nix nix-daemon
    run_confirm sudo systemctl enable --now nix-daemon
    echo "NOTE: open a new shell so /nix profile paths are picked up before running nix."
else
    echo "nix already installed."
fi

# 7. Dotfiles Repository
echo "--- Dotfiles Repository ---"
DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    run_confirm git clone https://github.com/SUBHAM-ROY/Dotfiles.git "$DOTFILES_DIR"
else
    echo "Dotfiles directory already exists. Pulling latest changes..."
    run_confirm git -C "$DOTFILES_DIR" pull
fi

# 8. Install Flatpaks (only things not packaged in Nix)
echo "--- Installing Flatpaks ---"
run_confirm flatpak install -y flathub \
    com.surfshark.Surfshark \
    org.kde.haruna

# 9. Stowing KDE (only stowed config left; everything else is Nix-managed)
echo "--- Stowing KDE ---"
echo "Tip: install KDE themes/icons/Krohnkite from the KDE store before stowing."
if [ -d "$DOTFILES_DIR/kde" ]; then
    run_confirm cp "$DOTFILES_DIR/kde/wallpaper/office-lofi.jpg" "$HOME/Downloads/"
    run_confirm stow -d "$DOTFILES_DIR" kde
fi

# 10. Grub Theme & Config
echo "--- Grub Theme & Config ---"
THEME_DIR="$HOME/Downloads/Elegant-grub2-themes"
if [ ! -d "$THEME_DIR" ]; then
    run_confirm git clone https://github.com/vinceliuice/Elegant-grub2-themes.git "$THEME_DIR"
else
    echo "Theme directory exists. Pulling latest changes..."
    run_confirm git -C "$THEME_DIR" pull
fi

if [ -d "$THEME_DIR" ]; then
    echo "Installing Grub theme..."
    run_confirm sudo "$THEME_DIR/install.sh" -t wave -p window -i right -c dark -l system
    echo "Updating Grub config..."
    run_confirm sudo grub2-mkconfig -o /boot/grub2/grub.cfg
    run_confirm rm -rf "$THEME_DIR"
fi

# Final instructions (highlighted in red)
RED='\033[1;31m'
NC='\033[0m'
printf "\n${RED}>>> NEXT: open a new shell and bootstrap Home Manager:${NC}\n"
printf "${RED}    nix --extra-experimental-features 'nix-command flakes' \\\\${NC}\n"
printf "${RED}        run home-manager/master -- switch --flake $DOTFILES_DIR/nix/home-manager#sroy${NC}\n"
printf "${RED}    After that you can use 'nh home switch' (alias: hms) for future updates.${NC}\n"
printf "${RED}    Then restart your session or reboot to apply all changes.${NC}\n"

