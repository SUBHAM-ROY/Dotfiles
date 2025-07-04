if status is-interactive
    # Commands to run in interactive sessions can go here
end

# aliases
alias ls='lsd'
alias cd='z'
alias gfc="git branch -a | fzf | sed 's/remotes\/origin\///' | xargs git checkout"
alias gfd="git branch | fzf --multi | xargs git branch -D"
alias vi=nvim
alias vim=nvim
alias tm=tmux

zoxide init fish | source
thefuck --alias | source
