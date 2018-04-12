# dotfiles

> 🛠 fish shell, CLI tooling, Git, Vim/Tmux for JS/React, sensible macOS defaults

![preview of vim]docs/preview.png)

## Shell

[`fish`](https://fishshell.com/) is used as the shell environment.

Why `fish` and not `bash` or `zsh`?

* Zero config, basic setup is sufficient.
* Syntax highlighting
* Inline auto-suggestions
* But most of all, it's _really_ fast.

### Plugins

Plugins are managed by [`fisherman`](https://github.com/fisherman/fisherman).

I recommend to quickly take a look at [this](https://github.com/fisherman/fisherman/issues/69) issue to see the advantages of using `fisherman` over `oh-my-fish`.

The following plugins are added upon [installation](#install).

* [`thefuck`](https://github.com/nvbn/thefuck) _(Magnificent app which corrects your previous console command.)_
* [`bass`](https://github.com/edc/bass) _(Make Bash utilities usable in Fish shell)_
* [`nvm`](https://github.com/creationix/nvm) _(Node Version Manager - Simple bash script to manage multiple active node.js versions)_
* [`z`](https://github.com/rupa/z) _(jump around)_
* [`pure`](https://github.com/rafaelrinaldi/pure) _(Port of the `pure` ZSH prompt to Fish 🐟)_

## Git

[mingit](https://github.com/evansendra/mingit) aliases are included.

```
a = add
b = branch
c = commit
cm = commit -m
co = checkout
d = diff
f = fetch
i = init
m = merge
s = status
```

See [`.gitconfig`](https://github.com/Murderlon/dotfiles/blob/master/.gitconfig) for additional included settings.

> **Note:** if you use my `.gitconfig` don't forget to change credentials under `[USER]`

**TIP:** an alias I personally can't live without.

```bash
alias g "git"; and funcsave g;
```

## Vim
<a name="vim"/>

All settings are commented in [`init.vim`](https://github.com/Murderlon/dotfiles/blob/master/init.vim)

## Installation

<a name="install"/>

You need [Homebrew](https://brew.sh/) as a prerequisite for these scripts.

If you want the entire setup, simply run this script.

```
./install
```

### Shell

Checkout [`.shell.sh`](https://github.com/Murderlon/dotfiles/blob/master/.shell.sh) to see the installation process.

```
./.shell
```

### Vim / Tmux

Move the following files to your user folder.

* `.vimrc`
* `.tmux.conf`
* `.tmuxline`
* `.vim_runtime/`

### macOS

Sensible macOS defaults. See [`.macOS.sh`](https://github.com/Murderlon/dotfiles/blob/master/.macOS.sh) to find out what that entails.

```
./.macOS
```

## Todo

* Add [vim-prettier](https://github.com/prettier/vim-prettier).
* Setup eslint for vim.
* Further improve vim for React and CSS-in-JS.

## Credits

[Mathias Bynens](https://github.com/mathiasbynens) / [dotfiles](https://github.com/mathiasbynens/dotfiles) _(bash installer scripts)_

[Amir Salihefendic](https://github.com/amix) / [vimrc](https://github.com/amix/vimrc) _(vim mapping and plugins)_

## License

[MIT](https://oss.ninja/mit/murderlon) © [Murderlon](https://github.com/Murderlon).
