# ezsh

A simple script to set up an opinionated, batteries-included zsh environment on macOS (and Linux). It installs zsh, oh-my-zsh, a bunch of useful plugins, Nerd Fonts, fzf, pyenv, fnm, and more — all under `~/.config/ezsh/` so your `$HOME` stays clean.

## What it installs

### Shell + framework
* [zsh](https://www.zsh.org/), `git`, and `wget` (via your system package manager: `apt`/`pacman`/`dnf`/`yum`/`brew`/`pkg`)
* [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) — cloned to `~/.config/ezsh/oh-my-zsh`, configured to use the built-in `candy` theme

### oh-my-zsh plugins (auto-cloned)
* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
* [zsh-completions](https://github.com/zsh-users/zsh-completions)
* [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
* [zsh-you-should-use](https://github.com/MichaelAquilina/zsh-you-should-use)
* [print-alias](https://github.com/brymck/print-alias)
* [k](https://github.com/supercrabtree/k) — better `ls`
* [fzf-tab](https://github.com/Aloxaf/fzf-tab) — fzf-powered tab completion

### Plus the built-in oh-my-zsh plugins enabled by default
`gh`, `extract`, `docker`, `docker-compose`, `pyenv`, `pip`, `git`, `python`, `colorize`, `fzf`

### Tools
* [fzf](https://github.com/junegunn/fzf) — cloned to `~/.config/ezsh/fzf`, with key bindings and completion installed
* [marker](https://github.com/jotyGill/marker) — bookmarked shell commands
* [pyenv](https://github.com/pyenv/pyenv) — installed via `brew` if available, otherwise via `pyenv.run`
* [fnm](https://github.com/Schniz/fnm) — fast Node version manager, plus the latest LTS Node
* [gvm](https://github.com/soulteary/gvm) — Go version manager (installed lazily on first shell start, from `personal_rc.zsh`)
* [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`) — installed lazily via brew on first shell start
* [goto](https://github.com/ajhenry/goto) — directory bookmarks (installed lazily via `npm` on first shell start)

### Fonts
Downloaded into `~/.fonts/` and registered via `fc-cache`:
* Hack Nerd Font
* RobotoMono Nerd Font
* DejaVuSansMono Nerd Font
* FiraCode Nerd Font
* The full `font-hack-nerd-font` cask via brew

## Aliases & helpers shipped in `ezshrc.zsh` / `personal_rc.zsh`

You can add or override these in your own files under `~/.config/ezsh/zshrc/`.

* `l` — `ls --hyperlink=auto -lAhrtF` (all files, sorted by recent, clickable)
* `e` — `exit`
* `ip` — `ip --color=auto`
* `myip` — print your external IP (`wget -qO- https://wtfismyip.com/text`)
* `python` — aliased to `python3`
* `nvm` — aliased to `fnm`
* `code` — `open -a Cursor`
* `xcode` — `open -a Xcode`
* `finder` — `open`
* `debug_chrome` — launch Chrome with remote debugging on port 9222
* `video_to_gif <file>` — convert a video to an optimized gif via `ffmpeg` + `gifsicle`
* `cheat <cmd> [query…]` — query [cheat.sh](https://github.com/chubin/cheat.sh)
* `speedtest` — run [speedtest-cli](https://github.com/sivel/speedtest-cli) on the fly
* `dadjoke` — fetch a joke from icanhazdadjoke.com
* `dict <word>` — dictionary lookup via `dict.org`
* `ipgeo [ip]` — geo info for an IP (yours by default)
* Plus oh-my-zsh built-ins like [`extract`](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/extract) (`x <archive>`)

The default editor is set to `code --wait` (works with Cursor since `code` is aliased to it).

## Layout

Everything lives under `~/.config/ezsh/`:

```
~/.config/ezsh/
├── oh-my-zsh/          # oh-my-zsh framework + plugins + themes
├── fzf/                # fzf checkout
├── marker/             # marker checkout
├── zshrc/              # YOUR personal *.zsh files (sourced automatically)
└── ezshrc.zsh          # main config sourced by ~/.zshrc
```

Your real `~/.zshrc` is tiny — it just sources `~/.config/ezsh/ezshrc.zsh` and any files you drop in `~/.config/ezsh/zshrc/`.

## Installation

Requirements:
* `git` to clone this repo
* [Homebrew](https://brew.sh/) (the script exits if `brew` isn't found)
* `python3` or `python` if you want to use `-c` to import bash history

```bash
git clone https://github.com/jotyGill/ezsh
cd ezsh
./install.sh -c        # only pass -c the first time; re-running with -c duplicates history entries
```

Flags:
* `-c`, `--cp-hist` — copy `~/.bash_history` into `~/.zsh_history`
* `-n`, `--non-interactive` — skip the `chsh` prompt at the end (useful in CI / Dockerfiles)

After installation, change your terminal font to one of the installed Nerd Fonts (RobotoMono, Hack, DejaVuSansM, or FiraCode), then open a new zsh session. In that new session, run `build-fzf-tab-module` once to build the fzf-tab module.

## Notes

* If you already had a `~/.zshrc`, it's backed up to `~/.zshrc-backup-<date>` before being overwritten.
* If text/icons look broken, your terminal isn't using a Nerd Font yet. See [powerline/fonts#185](https://github.com/powerline/fonts/issues/185).
* marker's default `Ctrl+t` clashed with fzf, so it's rebound to `Ctrl+b`.
* All oh-my-zsh plugins are installed under `~/.config/ezsh/oh-my-zsh/`. Other tools (fzf, marker) live in `~/.config/ezsh/`.
* `zsh-autosuggestions` may conflict with marker. If you don't use marker, enable it with `plugins+=(zsh-autosuggestions)` in a file under `~/.config/ezsh/zshrc/`.
* Customize the prompt by setting a different `ZSH_THEME` (or your own `PROMPT`) in a file under `~/.config/ezsh/zshrc/`. See `config/personal_rc.zsh` for an example of overrides.

Suggestions for more cool tools are always welcome!

## Uninstall

Delete `~/.zshrc` and `~/.config/ezsh/`, then restore your backup:

```bash
rm -rf ~/.config/ezsh ~/.zshrc
mv ~/.zshrc-backup-<date> ~/.zshrc   # if you had one
chsh -s "$(command -v bash)"         # or whichever shell you want back
```
