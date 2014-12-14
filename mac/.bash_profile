if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
export PS1="[\[\033[32m\]\w]\[\033[0m\]\$(__git_ps1)\n\[\033[1;36m\]\u\[\033[32m\]$ \[\033[0m\]"
export LSCOLORS=hefxcxdxbxegedabagacad

alias ls='ls -G'
alias absolventa-spring="tmuxifier load-window tmux-windows/absolventa-spring.window.sh"

export PATH="$HOME/.tmuxifier/bin:$PATH"
export PATH="$HOME/Library/Haskell/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
