{ config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "merlijn";
  home.homeDirectory = "/Users/merlijn";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.curl
    pkgs.difftastic
    pkgs.exa
    pkgs.fzf
    pkgs.jq
    pkgs.neovim
    pkgs.nodejs
    pkgs.redis
    pkgs.ripgrep
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

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

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
      ls = "exa";
      yarn = "corepack yarn";
      pnpm = "corepack pnpm";
    };

    initExtraFirst = lib.concatMapStrings (x: x + "\n") [
      "eval $(thefuck --alias)"
    ];
    
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
  };
}
