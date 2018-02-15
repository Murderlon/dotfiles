# Make sure we're the latest Homebrew.
brew update

# Upgrade already installed formulae.
brew upgrade

# Install fish shell.
brew install fish

# Install thefuck.
brew install thefuck

# Setup thefuck in config.fish.
echo 'thefuck --alias | source' > ~/.config/fish/config.fish

# Create an autoloaded fish function for thefuck to prevent start-up delay.
thefuck --alias > ~/.config/fish/functions/fuck.fish

# Install fisherman
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

# Install plugins
fisher z nvm rafaelrinaldi/pure edc/bass

echo 'Shell environment successfully setup, enjoy :)'
