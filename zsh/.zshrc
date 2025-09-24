# no c-s/c-q output freezing
setopt noflowcontrol
# allow expansion in prompts
setopt prompt_subst
# this is default, but set for share_history
setopt append_history
# save each command's beginning timestamp and the duration to the history file
setopt extended_history
# display PID when suspending processes as well
setopt longlistjobs
# try to avoid the 'zsh: no matches found...'
setopt nonomatch
# report the status of backgrounds jobs immediately
setopt notify
# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all
# not just at the end
setopt completeinword
# use zsh style word splitting
setopt noshwordsplit
# allow use of comments in interactive code
setopt interactivecomments

eval "$(starship init zsh)"
eval "$(lua $(brew --prefix z.lua)/share/z.lua/z.lua --init enhanced once zsh)"

autoload -U +X compinit && compinit
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
# source <(carapace _carapace)

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH=$PATH:/Users/merlijnvos/go/bin
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export EDITOR="nvim"
export SHELL="/bin/zsh"
export SNACKS_GHOSTTY=true

bindkey -s '^p' 'tmux-sessionizer\n'
bindkey '^R' history-incremental-search-backward

[ -s "/Users/merlijnvos/.bun/_bun" ] && source "/Users/merlijnvos/.bun/_bun"

alias vim="nvim"
alias ls="eza"
alias j="z"
alias tks="tmux kill-server"

alias claude="/Users/merlijnvos/.claude/local/claude"
eval "$(~/.local/bin/mise activate)"

eval $(thefuck --alias)
