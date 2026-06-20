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


# Reload plasma shell without logging out
alias reload-plasma="systemctl --user restart plasma-plasmashell"

# Set a timer
function timer
    echo "sleep $argv[1] && aplay -d 3 ~/Downloads/timer.wav" | at now
end

# Sleep after a certain time
function sleep_after
    echo "sleep $argv[1] && systemctl suspend" | sudo at now
end
