# CUSTOM SET-UP
        test -e $HOME/.bash/profile.common && . $HOME/.bash/profile.common > /dev/null
        test -e $HOME/.bash/profile.mac && . $HOME/.bash/profile.mac > /dev/null

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
