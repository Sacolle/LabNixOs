{ chnfig, pkgs, inputs, ... }:

{

  # NOTE: To apply the config, run `home-manager switch`
  # To rollback a change in the current configuration of NixOs, run `home-manager switch --rollback` 

  home.username = "colle";
  home.homeDirectory = "/home/colle";

  imports = [ inputs.nixvim.homeModules.nixvim ];
  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    # neofetch
    # nnn # terminal file manager

    # configured vim client
    lunarvim

    # forget the vim client
    vscode

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    # ripgrep # recursively searches directories for a regex pattern
    # jq # A lightweight and flexible command-line JSON processor
    # yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    trashy # rm with restore
    bat # cat with syntax higlight

    # networking tools
    # mtr # A network diagnostic tool
    # iperf3
    # dnsutils  # `dig` + `nslookup`
    # ldns # replacement of `dig`, it provide the command `drill`
    # aria2 # A lightweight multi-protocol & multi-source command-line download utility
    # socat # replacement of openbsd-netcat
    # nmap # A utility for network discovery and security auditing
    # ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    # cowsay
    # file
    # which
    # tree
    # gnused
    # gnutar
    # gawk
    # zstd
    # gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    # hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    # iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    # strace # system call monitoring
    # ltrace # library call monitoring
    # lsof # list open files

    # system tools
    # sysstat
    # lm_sensors # for `sensors` command
    # ethtool
    # pciutils # lspci
    # usbutils # lsusb
	
    # PDF visualizer
    sioyek
    texliveFull

    # obsidian
	obsidian

    zotero
    libreoffice
    gimp
    thunderbird

    # for git
    git-filter-repo

    # language servers for emacs, 
    # maybe gemini is not telling me a better way because it hates me
    # specifically
    clang-tools     # For C/C++ (clangd)
    nixd            # For Nix
    rPackages.languageserver # For R

    direnv

    # extra
    cockatrice
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "sacolle";
    userEmail ="pedro.h.b.colle@gmail.com";
  };

  programs.kitty = {
  	enable = true;
	enableGitIntegration = true;
	themeFile = "ayu_mirage";
    shellIntegration.enableZshIntegration = true;
    settings = {
        font_size = 14.0;
    };
  };

  # starship - an customizable prompt for any shell
  # programs.starship = {
  #   enable = true;
  #   # custom settings
  #   settings = {
  #     add_newline = false;
  #     aws.disabled = true;
  #     gcloud.disabled = true;
  #     line_break.disabled = true;
  #   };
  # };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  # programs.alacritty = {
  #   enable = true;
  #   # custom settings
  #   settings = {
  #     env.TERM = "xterm-256color";
  #     font = {
  #       size = 12;
  #       draw_bold_text_with_bright_colors = true;
  #     };
  #     scrolling.multiplier = 5;
  #     selection.save_to_clipboard = true;
  #   };
  # };

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        oh-my-zsh = {
            enable = true;
            plugins = [ "git" ];
            theme = "robbyrussell";
        };

        shellAliases = {
              rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#lab205-pc";
              # pcad = "ssh phbcolle@gppd-hpc.inf.ufrgs.br";
        };
        history.size = 10000;
    };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # eval "$(ssh-agent -s)"
    # ssh-add ~/.ssh/pcad_key

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#lab205-pc";
      # rm = "trash";
      ls = "eza -l --icons=always --git -h --no-user --no-time -g --group-directories-first";
      tree = "eza --tree --icons=always";
      cat = "bat -pp";
    };
  };

  programs.ssh = {
      extraConfig = "
        Host pcad
            User phbcolle
            Hostname gppd-hpc.inf.ufrgs.br
            IdentityFile ~/.ssh/pcad_key
      ";
  };

  programs.nixvim = {
    enable = true;
    vimAlias = true;
    viAlias = true;

    extraPackages = [
        pkgs.texliveFull
    ];
    
      plugins = {
         lualine.enable = true;
         telescope.enable = true;
         vimtex = {
            enable = true;
            
            settings = {
              view_method = "sioyek"; 
              view_automatic = true;
              compiler_method = "latexmk";
            };
          };
          # harpoon
          # lsp
          # oil -> file explorer
          # treesitter -> sintax highlight and stuff
          # vimtex?
          # which-key -> help with keybinds
          # markdown-preview -> 
          # lsp-format && lsp
          # lspsaga?
          # cmp -> code compleation https://github.com/LudovicDeMatteis/.dotfiles/blob/master/modules/neovim/plugins/cmp.nix
          bufferline = {
                enable = true;
                settings.options = {
                  numbers = "ordinal";     # Shows ordinal numbers (1, 2, 3...) on the tabs
                  diagnostics = "nvim_lsp"; # Shows LSP diagnostics in the bufferline
                  showBufferCloseIcons = true;
                  showCloseIcon = true;
              };
          };
          # nvim-tree -> sidebar
         #orgmode.enable = true;
      };

     opts = {
       number = true;
       relativenumber = true;
       expandtab = true; 
       tabstop = 4;
       softtabstop = 4;
       showtabline = 4;
       
       smartindent = true;
       # Number of spaces to use for each step of (auto)indent
       shiftwidth = 4;
       
       # Highlight the screen line of the cursor
       cursorline = true;
    
     };
     globals.mapleader = " ";
     keymaps = [
        {
            action = "<cmd>Explore<CR>";
            key = "<leader>ls";
            mode = [ "n" ];
            options = {
                silent = true;
            };
        }
        {
          mode = "n";
          key = "<leader><Tab>";
          action = "<cmd>BufferLineCycleNext<CR>";
          options = {
            desc = "Next buffer";
            silent = true;
          };
        }
        
        # Move to the previous buffer using <Shift> + <Tab>
        {
          mode = "n";
          key = "<leader><S-Tab>";
          action = "<cmd>BufferLineCyclePrev<CR>";
          options = {
            desc = "Previous buffer";
            silent = true;
          };
        }
        # Optional: Close the current buffer with <leader>bd
        {
          mode = "n";
          key = "<leader>d<Tab>";
          action = "<cmd>bdelete<CR>";
          options = {
            desc = "Delete buffer";
            silent = true;
          };
        }
     ];
  };

  programs.emacs = {
	enable = true;
	package = pkgs.emacs;
	extraPackages = epkgs: with epkgs; [
		nix-mode
        ess   # for R
        ace-window # for easier jumping in windows 
        monokai-pro-theme # dark theme for emacs
        ob-nix
        vterm # better terminal-emulator
		evil # vim binds for emacs
        envrc # to work better with nix
        telephone-line # line at the bottom
	];

	extraConfig = ''
		(setq standard-indent 4)
		(menu-bar-mode 0)
		(tool-bar-mode 0)
		(scroll-bar-mode 0)
		(global-display-line-numbers-mode)
		(require 'evil)
		(evil-mode 1)

        (org-babel-do-load-languages
            'org-babel-load-languages
            '(
                (R . t)
                (nix . t)
                (shell . t)
            )
        )
        (setq org-confirm-babel-evaluate nil)

        (use-package ace-window
            :bind ("M-o" . ace-window)
            :config
            (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
        )

        (use-package monokai-pro-theme
            :ensure t
            :config
            (load-theme 'monokai-pro t)
        )

        (use-package vterm)

        
        (use-package eglot
            :ensure nil ; It is built-in
            :hook (
                (c-mode . eglot-ensure)
                (c++-mode . eglot-ensure)
                (nix-mode . eglot-ensure)
                (ess-r-mode . eglot-ensure)
            )
            :config
            (add-to-list 'eglot-server-programs
                '(nix-mode . ("nixd"))
            )
        )

        ;; --- Custom Keybindings (Evil Normal State) ---
        (with-eval-after-load 'evil
            (evil-define-key 'normal 'global
                (kbd "SPC <tab>") 'next-buffer
                (kbd "SPC <backtab>") 'previous-buffer  ; <backtab> is Shift+Tab
                (kbd "SPC l s") 'find-file
                (kbd "SPC L S") 'find-file-other-window ; Requires holding Shift for L and S
            )
        )

        ;; --- Telephone Line Setup ---
        (require 'cl-lib)

        ;; Define click maps for the modeline
        (defvar my-modeline-prev-map
            (let ((map (make-sparse-keymap)))
                (define-key map [mode-line mouse-1] 'previous-buffer)
                map))
                
        (defvar my-modeline-next-map
            (let ((map (make-sparse-keymap)))
                (define-key map [mode-line mouse-1] 'next-buffer)
                map))


        (telephone-line-defsegment telephone-line-nav-buffer-segment ()
            (let* ((bufs (cl-remove-if (lambda (b) (string-match-p "^ " (buffer-name b))) (buffer-list)))
                   (curr (current-buffer))
                   (idx (cl-position curr bufs))
                   (prev (if (and idx (> idx 0)) (nth (1- idx) bufs) nil))
                   (next (if (and idx (< idx (1- (length bufs)))) (nth (1+ idx) bufs) nil)))
                (concat
                 (if prev (propertize (concat "« " (buffer-name prev) " ")
                                      'help-echo "Click: Previous buffer"
                                      'mouse-face 'mode-line-highlight
                                      'local-map my-modeline-prev-map)
                   "")
                 (propertize (buffer-name curr) 'face 'bold)
                 (if next (propertize (concat " " (buffer-name next) " »")
                                      'help-echo "Click: Next buffer"
                                      'mouse-face 'mode-line-highlight
                                      'local-map my-modeline-next-map)
                   ""))))

        ;; Apply Telephone Line configuration
        (use-package telephone-line
            :config
            (setq telephone-line-lhs
                  '((evil   . (telephone-line-evil-tag-segment))
                    (accent . (telephone-line-vc-segment
                               telephone-line-erc-modified-channels-segment
                               telephone-line-process-segment))
                    (nil    . (telephone-line-nav-buffer-segment)))) ; Replaced standard buffer segment
            (setq telephone-line-rhs
                  '((nil    . (telephone-line-misc-info-segment))
                    (accent . (telephone-line-major-mode-segment))
                    (evil   . (telephone-line-airline-position-segment))))
            (telephone-line-mode 1)
        )

        (use-package envrc
          :config
          (envrc-global-mode 1))
	'';
  };


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
