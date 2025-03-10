if not functions -q fundle
    eval (curl -sfL https://git.io/fundle-install)
end

fundle plugin jhillyerd/plugin-git
fundle init

set -U fish_greeting # Disable greeting
set -gx BUN_INSTALL "$HOME/.bun"
set -gx EDITOR nvim
set -gx SHELL fish

fish_add_path "$BUN_INSTALL/bin"
fish_add_path /Users/merlijnvos/go/bin

starship init fish | source
lua (brew --prefix z.lua)/share/z.lua/z.lua --init enhanced once fish | source

# mkdir -p ~/.config/fish/completions
# carapace --list | awk '{print $1}' | xargs -I{} touch ~/.config/fish/completions/{}.fish # disable auto-loaded completions (#185)
# carapace _carapace | source

alias vim="nvim"
alias ls="eza"
alias j="z"
alias g="g"
alias tks="tmux kill-server"
alias c="open $1 -a \"Cursor\""

bind \cp tmux-sessionizer
