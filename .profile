# CUSTOM SET-UP
        test -e $HOME/.bash/profile.common && . $HOME/.bash/profile.common > /dev/null
        test -e $HOME/.bash/profile.mac && . $HOME/.bash/profile.mac > /dev/null

source ~/.bash/completion/bash.sh
source ~/.bash/completion/git.sh

#
# Your previous .profile  (if any) is saved as .profile.mpsaved
# Setting the path for MacPorts.
# export PATH=/opt/local/bin:/opt/local/sbin:$PATH
