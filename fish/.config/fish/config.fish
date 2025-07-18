if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Setting variable for fish
fish_add_path /opt/homebrew/bin
set -U fish_greeting
set -U fish_color_autosuggestion 888888
set -U tide_time_format "%m/%d/%Y %r"
set -U tide_git_color_branch 6B8E5A
set -U tide_git_color_stash 6B8E5A
set -U tide_pwd_color_anchors 0087AF

# aliases
alias ls='lsd'
alias gfc="git branch -a | fzf | sed 's/remotes\/origin\///' | xargs git checkout"
alias gfd="git branch | fzf --multi | xargs git branch -D"
alias vi=nvim
alias vim=nvim
alias tm=tmux
alias top='btop'
alias cat='bat'
alias grep='rg'

function vplug
    nvim ~/.config/nvim/lua/plugins/$argv[1].lua
end

zoxide init fish | source
alias cd='z'
thefuck --alias | source
