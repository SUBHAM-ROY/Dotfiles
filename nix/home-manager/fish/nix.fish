
# Reload plasma shell without logging out
alias reload-plasma="systemctl --user restart plasma-plasmashell"

# Set a timer
function timer
    systemd-run --user --on-active=$argv[1] aplay -d 3 ~/Downloads/timer.wav
end

# Sleep after a certain time
function sleep_after
    systemd-run --on-active=$argv[1] sudo systemctl suspend
end
