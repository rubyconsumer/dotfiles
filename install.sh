#!/bin/bash
# Idempotent dotfiles installer: symlinks the tracked dotfiles into $HOME.
# Safe to re-run. Pass --dry-run (or -n) to preview without changing anything.
set -eu

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
OLD_DOTFILES="$HOME/Dropbox/wtsang/dotfiles"

DRY_RUN=0
if [ "${1:-}" = "--dry-run" ] || [ "${1:-}" = "-n" ]; then
  DRY_RUN=1
fi

FILES="
.profile
.bash_profile
.bashrc
.inputrc
.editrc
.umich_aliases
.tmux.conf
.gitconfig
.gitignore_global
.gemrc
.ruby-version
.vimrc
.gvimrc
"

linked=0
skipped=0
backed_up=0
pruned=0

run() {
  if [ "$DRY_RUN" -eq 1 ]; then
    echo "  would: $*"
  else
    "$@"
  fi
}

# link_file <repo path> <home path>
link_file() {
  src=$1
  dst=$2

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    skipped=$((skipped + 1))
    return 0
  fi

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "backing up: $dst -> $BACKUP_DIR/"
    run mkdir -p "$BACKUP_DIR"
    run mv "$dst" "$BACKUP_DIR/"
    backed_up=$((backed_up + 1))
  fi

  echo "linking: $dst -> $src"
  run ln -sfn "$src" "$dst"
  linked=$((linked + 1))
}

# Remove top-level $HOME symlinks that point into this repo (or its old
# Dropbox location) but whose target no longer exists — leftovers from
# files this repo used to ship (.rvmrc, .screenrc, .bash, ...).
prune_dead_links() {
  for link in "$HOME"/.[!.]* "$HOME"/*; do
    [ -L "$link" ] || continue
    target="$(readlink "$link")"
    case "$target" in
      "$DOTFILES"/*|"$OLD_DOTFILES"/*)
        if [ ! -e "$link" ]; then
          echo "pruning dead link: $link -> $target"
          run rm "$link"
          pruned=$((pruned + 1))
        fi
        ;;
    esac
  done
}

for name in $FILES; do
  link_file "$DOTFILES/$name" "$HOME/$name"
done
link_file "$DOTFILES/shell" "$HOME/.shell"

prune_dead_links

if [ ! -f "$DOTFILES/shell/secret-export.sh" ]; then
  echo "note: shell/secret-export.sh is missing (machine-local secrets; create it by hand)"
fi

if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  echo "bootstrapping vim-plug"
  run curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo
echo "done: $linked linked, $skipped already correct, $backed_up backed up, $pruned pruned"
if [ "$backed_up" -gt 0 ]; then
  echo "backups in: $BACKUP_DIR"
fi
if [ "$DRY_RUN" -eq 1 ]; then
  echo "(dry run: nothing was changed)"
fi
