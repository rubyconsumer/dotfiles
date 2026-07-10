# PostgreSQL client setup.

dotfiles_debug "mac-postgres.sh: loading"

export PGHOST=localhost

# PostgreSQL 18 client tools (Homebrew libpq, keg-only) for 10x Application
path_prepend /opt/homebrew/opt/libpq/bin
