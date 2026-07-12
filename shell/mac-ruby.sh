# Ruby: RVM manages per-project rubies (tenxmgmt pins 3.3.6 via
# .ruby-version; this repo pins "system" so RVM stays out of the way here).

dotfiles_debug "mac-ruby.sh: loading"

path_append "$HOME/.rvm/bin"
export PATH
[ -s "$HOME/.rvm/scripts/rvm" ] && . "$HOME/.rvm/scripts/rvm"
