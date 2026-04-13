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
run_confirm sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
run_confirm sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
run_confirm sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
run_confirm sudo dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/home:manuelschneid3r/Fedora_43/home:manuelschneid3r.repo
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

# 5.2. Install DNF Packages
echo "--- Installing DNF Packages ---"
run_confirm sudo dnf install -y \
    fish \
    snapper \
    brave-browser \
    keepassxc \
    tmux \
    kitty \
    git \
    node \
    albert \
    aria2 \
    samba \
    calibre \
    wine

run_confirm sudo dnf group install -y development-tools

# 6. Change Shell
echo "--- Changing Shell ---"
if [ "$SHELL" != "$(which fish)" ]; then
    run_confirm sudo chsh -s "$(which fish)" "$USER"
else
    echo "Shell is already fish."
fi

# 7. Homebrew Setup
echo "--- Homebrew Setup ---"
if [ ! -d "/home/linuxbrew/.linuxbrew" ]; then
    run_confirm /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Configuring Homebrew environment..."
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    echo "Installing brew packages..."
    run_confirm brew install \
        neovim \
        yazi \
        lazygit \
        lazydocker \
        fastfetch \
        gemini-cli \
        codex \
        btop \
        fd \
        ripgrep \
        bat \
        atuin \
        jq \
        zoxide \
        lsd \
        tldr \
        stow \
        uv \
        tree-sitter-cli \
        markdownlint-cli2 \
        ruff \
        stylua \
        fzf \
        ouch
else
    echo "Homebrew not found, skipping package installation."
fi

# 8. Install Flatpaks
echo "--- Installing Flatpaks ---"
run_confirm flatpak install -y flathub \
    md.obsidian.Obsidian \
    com.stremio.Stremio \
    com.surfshark.Surfshark \
    org.kde.haruna

# 9. Dotfiles Repository
echo "--- Dotfiles Repository ---"
DOTFILES_DIR="$HOME/Dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    run_confirm git clone https://github.com/SUBHAM-ROY/Dotfiles.git "$DOTFILES_DIR"
else
    echo "Dotfiles directory already exists. Pulling latest changes..."
    run_confirm git -C "$DOTFILES_DIR" pull
fi

# 10. Stowing
echo "--- Stowing configurations ---"
if [ -d "$HOME/Dotfiles" ]; then
    run_confirm stow -d "$HOME/Dotfiles" fish
    run_confirm stow -d "$HOME/Dotfiles" nvim
    run_confirm stow -d "$HOME/Dotfiles" tmux
    run_confirm stow -d "$HOME/Dotfiles" kitty
    run_confirm stow -d "$HOME/Dotfiles" fastfetch
    run_confirm stow -d "$HOME/Dotfiles" lazygit
    run_confirm stow -d "$HOME/Dotfiles" yazi
    echo "Tip: Install KDE themes/icons/Krohnkite from store before stowing."
    run_confirm cp "$HOME/Dotfiles/kde/wallpaper/office-lofi.jpg" "$HOME/Downloads/"
    run_confirm stow -d "$HOME/Dotfiles" kde
fi

# 11. Fedora-specific fish config
echo "--- Restoring Fedora-specific fish config ---"
run_confirm ln -sf "$HOME/Dotfiles/System Restore/personal.fish" "$HOME/.config/fish/conf.d/personal.fish"

# 12. Plugin Managers
echo "--- Setting up Plugin Managers ---"
# TPM
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing TPM..."
    run_confirm git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "TPM already exists"
fi

echo "Installing tmux plugins..."
run_confirm ~/.tmux/plugins/tpm/bin/install_plugins

# Fisher
FISHER_CONFIG="$HOME/.config/fish/functions/fisher.fish"
if [ ! -f "$FISHER_CONFIG" ]; then
    echo "Installing Fisher..."
    run_confirm fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
else
    echo "Fisher already exists."
fi

echo "Installing Fisher plugins..."
run_confirm fish -c "fisher update"

# 13. Grub Theme & Config
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

echo "Restoration complete! Please restart your session or reboot to apply all changes."
