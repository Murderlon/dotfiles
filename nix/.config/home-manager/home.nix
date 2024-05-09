{ config, lib, pkgs, ... }:
{
  home.username = "merlijnvos";
  home.homeDirectory = "/Users/merlijnvos";

  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    awscli2
    bash
    curl
    caddy
    deno
    difftastic
    eza
    fd
    fzf
    gh
    git
    git-lfs
    gnused
    lazygit
    luajit
    go
    jq
    neovim
    newt
    nodejs_20
    redis
    ripgrep
    rustup
    sqlite
    starship
    stow
    thefuck
    tmate
    tmux
    tokei
    tree-sitter
    wget
    z-lua

    # Fonts
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    # pkgs.jetbrains-mono
    # pkgs.iosevka
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "zsh";
    # TERM = "xterm-kitty";
    ZSH_AUTOSUGGEST_USE_ASYNC = 1;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableVteIntegration = true;

    autocd = true;

    shellAliases = {
      vim = "nvim";
      ls = "exa";
      yarn = "corepack yarn";
      pnpm = "corepack pnpm";
      j = "z";
      hms = "home-manager switch";
      hme = "home-manager edit";
      tks = "tmux kill-server";
    };

    initExtra = ''
      source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh                                                         ~ 
      source /nix/var/nix/profiles/default/etc/profile.d/nix.sh

      eval $(thefuck --alias)
      eval "$(rbenv init - zsh)"

      export PATH=$PATH:/Users/merlijnvos/go/bin

      bindkey -s '^p' 'tmux-sessionizer\n'
      bindkey -v
      bindkey '^R' history-incremental-search-backward
    '';

    historySubstringSearch = {
      enable = true;
    };

    plugins = [
      {
        name = "zsh-saneopt";
        file = "saneopt.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "willghatch";
          repo = "zsh-saneopt";
          rev = "8ec7ce0387309dcdb72b71ac85edc8799aa42792";
          sha256 = "sha256-g0hLvvmoPWjX9GW4f+xbFCVHN7TtOCUxDfD8oLEuNy4=";
        };
      }
      {
        name = "zephyr/completion";
        file = "plugins/completion/completion.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "mattmc3";
          repo = "zephyr";
          rev = "97723431a92e5b3cc035557365c0e206e580e149";
          sha256 = "sha256-p3In190ff1YypN+P9uTPjZuHnIyp9B/l0JJPcRkbIcY=";
        };
      }
      {
        name = "fast-syntax-highlighting";
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
        src = pkgs.zsh-fast-syntax-highlighting;
      }

      {
        name = "prezto";
        file = "share/zsh-prezto/modules/git/alias.zsh";
        src = pkgs.zsh-prezto;
      }

      # {
      #   name = "zsh-you-should-use";
      #   file = "you-should-use.plugin.zsh";
      #   src = pkgs.zsh-you-should-use;
      # }
    ];
  };

  programs.z-lua = {
    enable = true;
    enableAliases = true;
    enableZshIntegration = true;

    options = [
      "enhanced"
      "once"
      "fzf"
    ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$character";
      command_timeout = 2000;
      right_format = lib.concatStrings [
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"
        "$directory"
        "$hostname"
        "$line_break"
        "$status"
      ];
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };
      directory = {
        truncation_length = 2;
        style = "fg:242";
      };
      git_branch = {
        format = "[$symbol$branch]($style) ";
        symbol = " ";
        style = "green";
      };
    };
  };
}
