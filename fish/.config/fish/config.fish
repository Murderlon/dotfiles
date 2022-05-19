if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

fundle plugin 'edc/bass' # Make Bash utilities usable in Fish shell 
fundle plugin 'jethrokuan/z' # Pure-fish z directory jumping
fundle plugin 'jhillyerd/plugin-git' # Git plugin for Oh My Fish (similar to oh-my-zsh git) 

fundle init

# Load prompt
eval (starship init fish)

# Load thefuck
thefuck --alias | source

# Map z to j
set -U Z_CMD "j"
set -U Z_DATA "$HOME/.z"

set -gx EDITOR nvim
set -gx TERM screen-256color;

fish_add_path /usr/bin
fish_add_path /Users/merlijn/go/bin

bind \cp 'bass tmux-sessionizer.sh\n'
