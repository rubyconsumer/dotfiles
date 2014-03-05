# CUSTOM SET-UP
        test -e $HOME/.bash/profile.common && . $HOME/.bash/profile.common > /dev/null
        test -e $HOME/.bash/profile.mac && . $HOME/.bash/profile.mac > /dev/null

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
#source ~/.bash/completion/bash.sh
#source ~/.bash/completion/git.sh

#
# Your previous .profile  (if any) is saved as .profile.mpsaved
# Setting the path for MacPorts.
# export PATH=/opt/local/bin:/opt/local/sbin:$PATH
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
