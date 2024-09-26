# This my personal zshrc configs. Feel free to use it and modify according to your needs
# Place all your .zshrc configurations (including this one) in a single or multiple files under ~/.config/ezsh/zshrc/ folder

# Additional OH-MY-ZSH plugins to enable
plugins+=(
    docker
    docker-compose
    pyenv
    pip
    zsh-you-should-use
    print-alias
    git
    python
    colorize
    fzf
)

# Alias python3 to python
alias python="python3"

# Print alias config
export PRINT_ALIAS_PREFIX=$'\e[2m(alias) ──> '
export PRINT_ALIAS_FORMAT=$'\e[2m'
export PRINT_NON_ALIAS_FORMAT=$'\e[2m'

export PRINT_ALIAS_IGNORE_REDEFINED_COMMANDS=true
export PRINT_ALIAS_IGNORE_ALIASES=(example_alias)

# macos removed ruby, add it back with rbenv
export PATH="$HOME/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:$PATH"

# add vscode to path
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# setup fnm
eval "$(fnm env --use-on-cd)"
alias nvm=fnm

# goto setup
if ! type "goto-cli" >/dev/null; then
    if type "npm" >/dev/null; then
        npm i -g @ajhenry/goto
    else
        echo "npm not found. Please install it using npm"
    fi
else
    eval "$(goto-cli --init)"
fi

# convert video to gif
alias video_to_gif='function video_to_gif(){ ffmpeg -i $1 output.gif && gifsicle -O3 output.gif -o output.gif && say "Video is ready!"};video_to_gif'

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"
export PATH=$(pyenv root)/shims:$PATH

# add root tools to path
export PATH=/usr/sbin:$PATH
export PATH=/usr/local/bin:$PATH

# add brew to path
export PATH=/opt/homebrew/bin:$PATH

# go version manager
if [ ! -d "$HOME/.gvm" ]; then
    curl -sSL https://github.com/soulteary/gvm/raw/master/binscripts/gvm-installer | bash
fi

# Go path
if [ ! -d "$HOME/dev" ]; then
    mkdir -p $HOME/dev
fi
if [ ! -d "$HOME/dev/go" ]; then
    mkdir -p $HOME/dev/go
fi

# ripgrep setup
if ! type "rg" >/dev/null; then
    if type "brew" >/dev/null; then
        brew install ripgrep
    else
        echo "brew not found. Please install it using brew"
    fi
fi

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# alias for finder
alias finder="open"

# Set encoding
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

# Change default editor to vscode
export EDITOR="code --wait"
export VISUAL="$EDITOR"

# Chrome debugger
alias debug_chrome='open -a "Google Chrome" --args --remote-debugging-port=9222'
