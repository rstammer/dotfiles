if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

source ~/.git-completion.bash
source ~/.git-prompt.sh

MAGENTA="\[\033[0;35m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[34m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[0;36m\]"
GREEN="\[\033[0;32m\]"
GIT_PS1_SHOWDIRTYSTATE=true

export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

export PS1=$LIGHT_GRAY"\u"'$(
             if [[ $(__git_ps1) =~ \*\)$ ]]
               # a file has been modified but not added
               then echo "'$YELLOW'"$(__git_ps1 " (%s)")
               elif [[ $(__git_ps1) =~ \+\)$ ]]
                 # a file has been added, but not commited
                 then echo "'$MAGENTA'"$(__git_ps1 " (%s)")
               # the state is clean, changes are commited
               else echo "'$GREEN'"$(__git_ps1 " (%s)")
             fi)'$BLUE" \w"$LIGHT_GRAY": "

#export LSCOLORS=hefxcxdxbxegedabagacad

alias ls='ls -G'
alias absolventa-spring="tmuxifier load-window tmux-windows/absolventa-spring.window.sh"

export PATH="$HOME/.tmuxifier/bin:$PATH"
export PATH="$HOME/Library/Haskell/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
