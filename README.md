# dotfiles

Personal dotfiles, symlinked into `$HOME`. Primary shell is zsh with
[Oh My Zsh](https://ohmyz.sh/); bash remains fully supported as a fallback.

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
| `.zprofile` / `.zshrc` | zsh entry points: source `.profile`, then Oh My Zsh + the zsh layer |
| `.bash_profile` / `.bashrc` | bash entry points: source `.profile`, then the bash-only layer |
| `shell/` (linked as `~/.shell`) | shared shell config |
| `shell/env.sh`, `aliases.sh`, `ls.sh`, `bundle.sh` | POSIX-portable: works on any unix, any sh |
| `shell/mac.sh`, `mac-*.sh` | macOS-local: Homebrew, Volta, PostgreSQL, mac aliases. Skipped off-Darwin |
| `shell/zsh/` | **zsh-only**: extra options/bindings and `omz-custom/` (the `winstont` prompt theme) |
| `shell/bash/` | **bash-only**: options, completion, prompt (kept as the fallback shell) |
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

## zsh + Oh My Zsh

The installer clones Oh My Zsh to `~/.oh-my-zsh` if missing. `.zshrc` points
`ZSH_CUSTOM` into the repo (`shell/zsh/omz-custom/`), so the custom prompt
theme (`winstont` — a port of `shell/bash/prompt.bash` with the fill line,
git dirty flags, and minutes-since-last-commit timer) lives in git, not in
the OMZ checkout. vi editing mode comes from the OMZ `vi-mode` plugin;
history dedup/timestamps and case-insensitive completion come from OMZ
defaults, replacing what `shell/bash/options.bash` and `.inputrc` did for
bash. OMZ auto-update is disabled — run `omz update` by hand.

The bash layer (`shell/bash/`, `.bash_profile`, `.bashrc`, `.inputrc`) is
kept working as a fallback; both shells share everything under `shell/*.sh`.
