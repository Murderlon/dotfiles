# no c-s/c-q output freezing
setopt noflowcontrol
# allow expansion in prompts
setopt prompt_subst
# this is default, but set for share_history
setopt append_history
setopt share_history
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
eval "$(~/.local/bin/mise activate)"
eval $(thefuck --alias)

autoload -U +X compinit && compinit
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'

# source <(carapace _carapace)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -s "/Users/merlijnvos/.bun/_bun" ] && source "/Users/merlijnvos/.bun/_bun"

export PATH=$PATH:/Users/merlijnvos/go/bin
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
export EDITOR="nvim"
export SHELL="/bin/zsh"
export SNACKS_GHOSTTY=true

bindkey -s '^p' 'tmux-sessionizer\n'
bindkey '^R' history-incremental-search-backward

alias vim="nvim"
alias ls="eza"
alias j="z"
alias tks="tmux kill-server"
alias claude="/Users/merlijnvos/.claude/local/claude"
alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

mkcd () {
  \mkdir -p "$1"
  cd "$1"
}

tempe () {
  cd "$(mktemp -d)"
  chmod -R 0700 .
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
    chmod -R 0700 .
  fi
}

# makes a happy sound if the previous command succeeded and a sad sound otherwise
boop () {
  local last="$?"
  if [[ "$last" == '0' ]]; then
    sfx good
  else
    sfx bad
  fi
  $(exit "$last")
}
