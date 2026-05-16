{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Fish and all configs
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings

      bind -M insert jj 'set fish_bind_mode default'
      bind -M insert ctrl-p up-or-search
      bind -M insert ctrl-n down-or-search
      bind -M insert ctrl-f forward-char
    '';

    shellAliases = {
      ls = "lsd";
      la = "lsd -A";
      ll = "lsd -lA";
      lt = "lsd --tree --depth 3";

      vi = "nvim";
      vim = "nvim";

      tm = "tmux";
      ta = "tmux a || tmux new";

      top = "btop";
      cat = "bat";
      ff = "fastfetch";
      cd = "z";

      fdf = "fd -t f -u";
      fdd = "fd -t d -u";

      ngc = "nh clean user";
      hms = "nh home switch";
      hmu = "nh home switch -u";
      hmg = "home-manager generations";
      he = "cd ~/.config/home-manager && vi ~/.config/home-manager/home.nix";

      gfc = "git branch -a | fzf | sed 's/remotes\\/origin\\///' | xargs git checkout";
      gfd = "git branch | fzf --multi | xargs git branch -D";
    };

    functions = {
      vplug = ''
        nvim ~/.config/nvim/plugins/$argv[1].lua
      '';
    };

    shellInit = ''
      # Homebrew setup (for macOS)
      if test -d /opt/homebrew
          set -gx HOMEBREW_PREFIX "/opt/homebrew"
          eval (/opt/homebrew/bin/brew shellenv fish)
          set -p fish_complete_path /opt/homebrew/share/fish/vendor_completions.d
      end

      # Homebrew envs
      set -gx HOMEBREW_NO_UPDATE_REPORT_NEW 1
      set -gx HOMEBREW_UPGRADE_GREEDY 1
      set -gx HOMEBREW_API_AUTO_UPDATE_SECS 86400
      set -gx HOMEBREW_AUTO_UPDATE_SECS 259200

      # Editor
      set -gx EDITOR ${pkgs.neovim}/bin/nvim
      set -gx MANPAGER '${pkgs.neovim}/bin/nvim +Man!'

      # Fish appearance/settings
      set -g fish_greeting
      set -g fish_color_autosuggestion 888888

      # Tide
      set -g tide_time_format "%m/%d/%Y %r"
      set -g tide_git_color_branch 6B8E5A
      set -g tide_git_color_stash 6B8E5A
      set -g tide_pwd_color_anchors 0087AF
    '';
    plugins = [
      {
        src = pkgs.fishPlugins.tide.src;
        name = "tide";
      }
    ];
  };

  # Only apply this symlink if we are on Linux
  home.file.".config/fish/conf.d/fedora.fish" = lib.mkIf pkgs.stdenv.isLinux {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nix/.config/home-manager/fish/fedora.fish";
  };
}
