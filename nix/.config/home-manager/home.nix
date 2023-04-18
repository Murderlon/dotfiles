{ config, lib, pkgs, ... }:

{
  home.username = "merlijn";
  home.homeDirectory = "/Users/merlijn";

  home.stateVersion = "22.11";

  home.packages = [
    pkgs.curl
    pkgs.difftastic
    pkgs.exa
    pkgs.fd
    pkgs.fzf
    pkgs.git
    pkgs.git-lfs
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
      #TODO: eval $(thefuck --alias --enable-experimental-instant-mode)
      bindkey -s '^p' 'tmux-sessionizer.sh\n'
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
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "7c390ee3bfa8069b8519582399e0a67444e6ea61";
          sha256 = "sha256-wLpgkX53wzomHMEpymvWE86EJfxlIb3S8TPy74WOBD4=";
        };
      }
      {
        name = "zephyr/directory";
        file = "plugins/directory/directory.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "mattmc3";
          repo = "zephyr";
          rev = "9e94963fc0934ab87a65d1b60de0fe628748b535";
          sha256 = "sha256-EfM5tKg/Tb9ID/B4q4j8yEjUbId5QLPfy0TxVK7Bx5Q=";
        };
      }
      {
        name = "zephyr/environment";
        file = "plugins/environment/environment.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "mattmc3";
          repo = "zephyr";
          rev = "9e94963fc0934ab87a65d1b60de0fe628748b535";
          sha256 = "sha256-EfM5tKg/Tb9ID/B4q4j8yEjUbId5QLPfy0TxVK7Bx5Q=";
        };
      }
      {
        name = "zephyr/history";
        file = "plugins/history/history.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "mattmc3";
          repo = "zephyr";
          rev = "9e94963fc0934ab87a65d1b60de0fe628748b535";
          sha256 = "sha256-EfM5tKg/Tb9ID/B4q4j8yEjUbId5QLPfy0TxVK7Bx5Q=";
        };
      }
      {
        name = "zephyr/utility";
        file = "plugins/utility/utility.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "mattmc3";
          repo = "zephyr";
          rev = "9e94963fc0934ab87a65d1b60de0fe628748b535";
          sha256 = "sha256-EfM5tKg/Tb9ID/B4q4j8yEjUbId5QLPfy0TxVK7Bx5Q=";
        };
      }
      {
        name = "zephyr/completion";
        file = "plugins/completion/completion.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "mattmc3";
          repo = "zephyr";
          rev = "9e94963fc0934ab87a65d1b60de0fe628748b535";
          sha256 = "sha256-EfM5tKg/Tb9ID/B4q4j8yEjUbId5QLPfy0TxVK7Bx5Q=";
        };
      }
      {
        name = "prezto/git";
        file = "modules/git/alias.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "sorin-ionescu";
          repo = "prezto";
          rev = "fc444f57e11131b2cad68f474bcf1201cba062a4";
          sha256 = "sha256-oEpbcCKzRtqqAKghYsQGf8s2eatcCpQTP1jPDxfNJ/M=";
        };
      }
      {
        name = "zsh-safe-rm";
        src = pkgs.fetchFromGitHub {
          owner = "mattmc3";
          repo = "zsh-safe-rm";
          rev = "9463e7def5932e8c1958f8c023621bbddcfa2a58";
          sha256 = "sha256-dIAt1HYOY5MF5hCRm4YW2VXr/a2g3GEFq/Xa/IpPqgU=";
          fetchSubmodules = true;
        };
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
