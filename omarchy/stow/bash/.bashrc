# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# Use this machine's OpenSSH agent in desktop and remote SSH shells.
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/ssh-agent.socket"

# If not running interactively, don't do anything else (leave this above the rc source)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source "$OMARCHY_PATH/default/bash/rc"

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
alias vim='nvim'

# Set the brightness of the LG monitor connected on DP-1.
brightness() {
  local value="${1:-}"
  value="${value%%%}"

  if [[ -z $value ]]; then
    ddcutil --bus 9 getvcp 10
    return
  fi

  if [[ ! $value =~ ^[0-9]+$ ]] || (( value < 1 || value > 100 )); then
    printf 'Usage: brightness [1-100]\n' >&2
    return 2
  fi

  ddcutil --bus 9 setvcp 10 "$value"
}
eval "$(direnv hook bash)"
