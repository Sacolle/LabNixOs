{ config, pkgs, inputs, ... }:

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

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    # ripgrep # recursively searches directories for a regex pattern
    # jq # A lightweight and flexible command-line JSON processor
    # yq-go # yaml processor https://github.com/mikefarah/yq
    # TODO: alias ls
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

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
    kdePackages.okular

    # obsidian
	obsidian
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

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#lab205-pc";
      caim = "cd ~/ccbn-p2p-im && cargo run";
      # urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      # urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

# Fucking helix, fui baitado. Só funciona, mas sem os keybinds do VIM,
# eu preciso dos meus keybinds cara, eu preciso deles

#  programs.helix = {
#  enable = true;
#  settings = {
#    theme = "autumn_night_transparent";
#    editor = { 
#    	cursor-shape = {
#	    normal = "block";
#	    insert = "bar";
#	    select = "underline";
#    	};
#	line-number = "relative";
#	lsp.display-messages = true;
#    };
#  };
#  languages.language = [
#    {
#      name = "nix";
#      auto-format = true;
#      formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
#    }
#    {
#      name = "haskell";
#      auto-format = false;
#      #formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
#    }
#
#  ];
#  themes = {
#    autumn_night_transparent = {
#      "inherits" = "autumn_night";
#      "ui.background" = { };
#    };
#  };
#};
  programs.nixvim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    
      plugins = {
         lualine.enable = true;
          # telescope
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
          # bufferline -> tabs dos arquivos abertos no topo
          # nvim-tree -> sidebar
         orgmode.enable = true;
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
