# Package update aliases
set -l dnf_update "sudo dnf upgrade --refresh && sudo dnf autoremove"
set -l brew_update "brew update && brew upgrade --greedy && brew cleanup --prune=all"
set -l flatpak_update "flatpak update && flatpak uninstall --unused"
alias update="$dnf_update; $brew_update; $flatpak_update"

# convert wget/curl list to aria2c input format
function convert_to_aria2c
    set -l file $argv[1]
    set -l index 1
    cat $file | while read -l url
        echo "$url" >> aria.txt
        printf "  out=%02d.mkv\n" $index >> aria.txt
        set index (math $index + 1)
    end
    cat aria.txt
end


# setup podman socket for lazydocker
if not systemctl --user is-active podman.socket >/dev/null 2>&1
    systemctl enable --user --now podman.socket
end
set -gx DOCKER_HOST "unix:///run/user/1000/podman/podman.sock"

# Remove all old kernels except the latest one
function remove_old_kernels
    sudo dnf remove (sudo dnf repoquery --installonly --latest-limit=-1 -q) -y
end

# Reload plasma shell without logging out
alias reload-plasma="kquitapp6 plasmashell && kstart plasmashell"

# Remove multiple snapper snapshots selectively
function remove_snapper
    snapper -c $argv[1] ls | fzf --reverse --multi | perl -lane 'print $F[0]' | xargs snapper -c $argv[1] remove
end
