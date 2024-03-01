{ config, pkgs, lib, ... }:

let name = "TJ Lavelle";
    user = "tlavelle";
    email = "tj@lavelle.io"; in
{
  # Shared shell configuration
  zsh = {
    enable = true;
    autocd = false;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./config;
        file = "p10k.zsh";
      }
    ];

    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'
    '';
  };

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = { 
	editor = "vim";
        autocrlf = "input";
      };
      pull.rebase = true;
      rebase.autoStash = true;
    };
 };

  neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      tmux-navigator
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local builtin = require('telescope.builtin')
          vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
          vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
          vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
          vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        '';
      }
      vim-nix
    ];
 };

  alacritty = {
    enable = true;
    settings = {
      cursor = {
        style = "Block";
      };

      window = {
        dynamic_padding = true;
        opacity = 1.0;
        padding = {
          x = 24;
          y = 24;
        };
        decorations = "full";
        title = "Terminal";
        class = {
          instance = "Alacritty";
          general = "Alacritty";
        };
      };

      font = {
        normal = {
          # family = "MesloLGS NF";
          # style = "Regular";
        };
        size = lib.mkMerge [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux 10)
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin 14)
        ];
      };

      colors = {
        primary = {
          background = "0x1f2528";
          foreground = "0xc0c5ce";
        };

        normal = {
          black = "0x1f2528";
          red = "0xec5f67";
          green = "0x99c794";
          yellow = "0xfac863";
          blue = "0x6699cc";
          magenta = "0xc594c5";
          cyan = "0x5fb3b3";
          white = "0xc0c5ce";
        };

        bright = {
          black = "0x65737e";
          red = "0xec5f67";
          green = "0x99c794";
          yellow = "0xfac863";
          blue = "0x6699cc";
          magenta = "0xc594c5";
          cyan = "0x5fb3b3";
          white = "0xd8dee9";
        };
      };
    };
  };

  ssh = {
    enable = true;

    extraConfig = lib.mkMerge [
      ''
        Host github.com
          Hostname github.com
          IdentitiesOnly yes

        Host cloud
          Hostname tjlav5.c.googlers.com
          LocalForward 9990 localhost:9990
      ''
      # (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
      #   ''
      #     IdentityFile /home/${user}/.ssh/id_github
      #   '')
      # (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
      #   ''
      #     IdentityFile /Users/${user}/.ssh/id_github
      #   '')
    ];
  };

  tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    prefix = "C-Space";
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      sensible
      yank
      prefix-highlight
      {
        plugin = rose-pine;
        extraConfig = ''
           set -g @rose_pine_variant 'moon'
        '';
      }
      {
        plugin = resurrect; # Used by tmux-continuum

        # Use XDG data directory
        # https://github.com/tmux-plugins/tmux-resurrect/issues/348
        extraConfig = ''
          set -g @resurrect-dir '$HOME/.cache/tmux/resurrect'
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-pane-contents-area 'visible'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5' # minutes
        '';
      }
    ];
    terminal = "screen-256color";
    escapeTime = 10;
    historyLimit = 50000;
    extraConfig = ''
      # Remove Vim mode delays
      set -g focus-events on

      # -----------------------------------------------------------------------------
      # Key bindings
      # -----------------------------------------------------------------------------

      # Split panes, vertical or horizontal
      bind-key x split-window -v
      bind-key v split-window -h
      '';
    };
}
