if status is-interactive
    fish_vi_key_bindings
    bind -M insert jj 'set fish_bind_mode default'
    bind -M insert ctrl-p up-or-search
    bind -M insert ctrl-n down-or-search
    bind -M insert ctrl-f forward-char
end

# homebrew setup
if test -d /home/linuxbrew/.linuxbrew
    set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
else if test -d /opt/homebrew
    set -gx HOMEBREW_PREFIX "/opt/homebrew"
end

if set -q HOMEBREW_PREFIX
    eval ($HOMEBREW_PREFIX/bin/brew shellenv fish)
    set -p fish_complete_path $HOMEBREW_PREFIX/share/fish/vendor_completions.d
end

# brew envs
set -gx HOMEBREW_NO_UPDATE_REPORT_NEW 1
set -gx HOMEBREW_UPGRADE_GREEDY 1
set -gx HOMEBREW_API_AUTO_UPDATE_SECS 86400 # 24 hours
set -gx HOMEBREW_AUTO_UPDATE_SECS 259200 # 72 hours

# Setting variable for fish
set -U fish_greeting
set -U fish_color_autosuggestion 888888
set -U tide_time_format "%m/%d/%Y %r"
set -U tide_git_color_branch 6B8E5A
set -U tide_git_color_stash 6B8E5A
set -U tide_pwd_color_anchors 0087AF

set -gx EDITOR $(which nvim)
set -gx MANPAGER 'nvim +Man!'
set -gx RIPGREP_CONFIG_PATH ~/.rgrc

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
alias cd='z'


# More useful aliases
alias fdf='fd -t f -u'
alias fdd='fd -t d -u'
alias la='lsd -A'
alias ll='lsd -lA'
alias lt='lsd --tree --depth 3'

function vplug
    nvim ~/.config/nvim/plugins/$argv[1].lua
end

zoxide init fish | source
atuin init fish | source
