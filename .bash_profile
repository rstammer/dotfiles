export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

# add tmuxifier
export PATH="~/.tmuxifier/bin:$PATH"

# window aliases
alias absolventa="tmuxifier load-window tmux-windows/absolventa.window.sh"
alias jobnet="tmuxifier load-window tmux-windows/jobnet.window.sh"
alias praktikum-info="tmuxifier load-window tmux-windows/praktikum-info.window.sh"
alias kanyotoku="tmuxifier load-window tmux-windows/kanyotoku.window.sh"
alias trainee-gefluester="tmuxifier load-window tmux-windows/trainee-gefluester.window.sh"
alias interna="tmuxifier load-window tmux-windows/interna.window.sh"

alias c3po="tmuxifier load-window tmux-windows/c3po.window.sh"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

export PS1='\h:\W \[\033[0;36m\]$(__git_ps1 "[%s] ")\[\033[0m\]\$ '

# coloured output and better readability on black terminal backgrouns
export LSCOLORS=hefxcxdxbxegedabagacad
alias ls='ls -G'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
