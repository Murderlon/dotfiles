{ config, lib, pkgs, ... }:

{
  home.username = "merlijn";
  home.homeDirectory = "/Users/merlijnvos";

  home.stateVersion = "22.11";

  home.packages = [
    pkgs.awscli2
    pkgs.bash
    pkgs.curl
    pkgs.difftastic
    pkgs.exa
    pkgs.fd
    pkgs.fzf
    pkgs.gh
    pkgs.git
    pkgs.git-lfs
    pkgs.gnused
    pkgs.go
    pkgs.jq
    pkgs.neovim
    pkgs.newt
    pkgs.nodejs
    pkgs.redis
    pkgs.ripgrep
    pkgs.rustup
    pkgs.sqlite
    pkgs.starship
    pkgs.stow
    pkgs.terraform
    pkgs.thefuck
    pkgs.tmate
    pkgs.tmux
    pkgs.tokei
    pkgs.tree-sitter
    pkgs.wget
    pkgs.z-lua

    (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "zsh";
    TERM = "xterm-kitty";
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
      eval $(thefuck --alias)
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
