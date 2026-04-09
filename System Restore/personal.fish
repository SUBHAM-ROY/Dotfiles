##################################################
# Package manager update shortcuts
##################################################
set -l dnf_update "sudo dnf update && sudo dnf upgrade --refresh && sudo dnf autoremove"
set -l brew_update "brew update && brew upgrade --greedy && brew cleanup --prune=all"
set -l flatpak_update "flatpak update && flatpak uninstall --unused"
alias update="$dnf_update; $brew_update; $flatpak_update"

##################################################
# Bulk download converter for aria2c
##################################################
function convert_to_aria2c
    set -l file $argv[1]
    set -l index 1
    cat $file | while read -l url
        echo "$url" >> aria.txt
        echo "  out=$index.mkv" >> aria.txt
        set index (math $index + 1)
    end
    cat aria.txt
end


##################################################
# Podman socket (Docker-compatible)
##################################################
if not systemctl --user is-active podman.socket >/dev/null 2>&1
    systemctl enable --user --now podman.socket
end

set -gx DOCKER_HOST "unix:///run/user/1000/podman/podman.sock"

##################################################
# Remove old Fedora kernels
##################################################
function remove_old_kernels
    sudo dnf remove (sudo dnf repoquery --installonly --latest-limit=-1 -q) -y
end
