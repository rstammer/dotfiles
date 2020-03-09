if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

source ~/.git-completion.bash
source ~/.git-prompt.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

MAGENTA="\[\033[0;35m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[34m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[0;36m\]"
GREEN="\[\033[0;32m\]"
GIT_PS1_SHOWDIRTYSTATE=true

export TEST_ENV_NUMBER=2
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

export LSCOLORS=hefxcxdxbxegedabagacad
export R_HOME=/usr/local/Frameworks/R.framework/Resources

alias restart_sound="sudo kill -9 `ps ax|grep 'coreaudio[a-z]' | awk '{print $1}'`"

alias ls='ls -G'
alias migrate="bundle exec rails db:migrate && bundle exec rails db:migrate RAILS_ENV=test"
alias rollback="bundle exec rails db:rollback && bundle exec rails db:rollback RAILS_ENV=test"

# added for RabbitMQ
PATH=$PATH:/usr/local/sbin
export CLASSPATH=$CLASSPATH:~/java-extensions/postgresql-9.4.1207.jre6.jar
export PGHOST=localhost
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
export PATH="$HOME/Library/Haskell/bin:$PATH"
export PATH="$HOME/.tmuxifier/bin:$PATH"
export PATH=~/.local/bin:$PATH
export PATH=~/bin:$PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# added by Anaconda2 4.4.0 installer
export PATH="/Users/robin/anaconda2/bin:$PATH"
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"
