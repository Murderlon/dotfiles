HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
setopt autocd

source ~/.zplug/init.zsh
source ~/.aliases

eval $(thefuck --alias)

# Let zplug self-manage
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Fish-like autosuggestions for zsh 
zplug 'zsh-users/zsh-autosuggestions'
ZSH_AUTOSUGGEST_USE_ASYNC=true
bindkey '^n' autosuggest-execute

# zsh-syntax-highlighting after compinit and sourcing others
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

# history-substring-search after zsh-syntax-highlighting
zplug 'zsh-users/zsh-history-substring-search', defer:3

# prompt
zplug 'subnixr/minimal'

# git aliases
zplug 'modules/git', from:prezto

# jump around
zplug 'rupa/z', use:'z.sh'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# Set up history-substring-search keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
