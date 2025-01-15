eval "$(starship init zsh)"
eval "$(thefuck --alias)"
eval "$(lua $(brew --prefix z.lua)/share/z.lua/z.lua --init enhanced once zsh)"

autoload -U +X compinit && compinit
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

export PATH=$PATH:/Users/merlijnvos/go/bin
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Environment Variables
export EDITOR="nvim"
export SHELL="zsh"

# Aliases
alias vim="nvim"
alias ls="eza"
alias j="z"
alias tks="tmux kill-server"

# Keybindings
bindkey -s '^p' 'tmux-sessionizer\n'
bindkey '^R' history-incremental-search-backward
