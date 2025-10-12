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

set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man!'

# aliases
alias ls='lsd'
alias gfc="git branch -a | fzf | sed 's/remotes\/origin\///' | xargs git checkout"
alias gfd="git branch | fzf --multi | xargs git branch -D"
alias vi=nvim
alias vim=nvim
alias tm=tmux
alias ta='tmux a || tmux new'
alias top='btop'
alias cat='bat'
alias grep='rg'
alias yy='yazi'
alias gg='lazygit'
alias ff='fastfetch'

function vplug
    nvim ~/.config/nvim/lua/plugins/$argv[1].lua
end

zoxide init fish | source
alias cd='z'
thefuck --alias | source
if test -f ~/.config/fish/config-personal.fish
    source ~/.config/fish/config-personal.fish
end
