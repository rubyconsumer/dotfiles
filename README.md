# dotfiles

Personal dotfiles, symlinked into `$HOME`. Currently bash, structured so a
future zsh migration only has to replace one directory (see below).

## Install

```sh
./install.sh --dry-run   # preview
./install.sh
```

The installer derives the repo location from its own path, so it works from
any checkout location. It backs up real files it would replace (into
`~/.dotfiles-backup/<timestamp>/`), skips links that are already correct,
prunes dangling links left over from files the repo no longer ships, and
bootstraps [vim-plug](https://github.com/junegunn/vim-plug) if missing.
Re-running it is always safe.

## Layout

| Path | Purpose |
|---|---|
| `.profile` | POSIX login entry point — portable to any unix |
| `.bash_profile` / `.bashrc` | bash entry points: source `.profile`, then the bash-only layer |
| `shell/` (linked as `~/.shell`) | shared shell config |
| `shell/env.sh`, `aliases.sh`, `ls.sh`, `bundle.sh` | POSIX-portable: works on any unix, any sh |
| `shell/mac.sh`, `mac-*.sh` | macOS-local: Homebrew, Volta, PostgreSQL, mac aliases. Skipped off-Darwin |
| `shell/bash/` | **bash-only**: options, completion, prompt — the zsh-port worklist |
| `shell/secret-export.sh` | machine-local secrets; gitignored, create by hand |
| `.vimrc` / `.gvimrc` | self-contained vim config on vim-plug |
| everything else | per-tool configs linked straight into `$HOME` |

Rules of the layering:

- `shell/*.sh` must stay POSIX and portable — no bash-isms, no mac paths.
- macOS-only things go in `shell/mac.sh` or a `shell/mac-*.sh` helper.
- bash-only things (prompt, history options, completion) go in `shell/bash/`.
- Use `path_prepend <dir>` (defined in `env.sh`) instead of editing `$PATH`
  by hand — it deduplicates and skips missing directories.
- Set `DOTFILES_DEBUG=1` to trace what gets sourced at shell startup.

## Future zsh migration

The login shell is already `/bin/zsh`; bash is launched by the terminal
profile. To migrate:

1. Add `.zprofile` that sources `~/.profile` (all of `shell/*.sh` is POSIX
   and works unchanged), then a new `shell/zsh/` layer.
2. Port `shell/bash/`, the only bash-specific code:
   - `options.bash`: `HISTCONTROL` → `setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE`;
     `HISTTIMEFORMAT` → `setopt EXTENDED_HISTORY`; `set -o vi` → `bindkey -v`.
   - `completion.bash` → `autoload -Uz compinit && compinit` (git completion
     ships with zsh).
   - `prompt.bash`: `PROMPT_COMMAND` → `precmd()`; the `DEBUG` trap → `preexec()`;
     PS1 escapes `\u \h \w \[ \]` → `%n %m %~ %{ %}`.
3. `.inputrc` is readline-only — port its bindings to `bindkey` in `.zshrc`.
4. Point the terminal profile at zsh.
