export PS1='\h:\W \[\033[0;36m\]$(__git_ps1 "[%s] ")\[\033[0m\]\$ '
export LSCOLORS=hefxcxdxbxegedabagacad

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
