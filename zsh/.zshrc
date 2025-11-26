# no c-s/c-q output freezing
setopt noflowcontrol
# allow expansion in prompts
setopt prompt_subst
# this is default, but set for share_history
setopt append_history
setopt share_history
# save timestamp/duration and keep history clean/usable
setopt extended_history inc_append_history_time hist_ignore_all_dups hist_reduce_blanks hist_verify
HISTFILE="$HOME/.zsh_history"
HISTSIZE=200000
SAVEHIST=200000
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
# keep a quiet, deduped directory stack when using cd
setopt autopushd pushd_ignore_dups pushd_silent

# load prompts/tools and fail loudly if something is missing
eval "$(starship init zsh)"
eval "$(lua $(brew --prefix z.lua)/share/z.lua/z.lua --init enhanced once zsh)"
eval "$(~/.local/bin/mise activate)"

autoload -Uz compinit && compinit -C -d ~/.cache/zcompdump  # cached compinit for faster startup
zmodload zsh/complist
zstyle ':completion:*' menu select  # tab to scroll completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=**'  # case-insensitive, fuzzy-ish matches
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'

# source <(carapace _carapace)
typeset -U path  # dedupe PATH entries
export BUN_INSTALL="$HOME/.bun"
path=(/opt/homebrew/opt/node@22/bin /opt/homebrew/opt/rustup/bin "$BUN_INSTALL/bin" "$HOME/.local/bin" "$HOME/go/bin" $path)
export PATH
source "/Users/merlijnvos/.bun/_bun"
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

# make directory and cd into it
mkcd () {
  \mkdir -p "$1"
  cd "$1"
}

# create a temporary directory and cd into it
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

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # keep highlighting last
