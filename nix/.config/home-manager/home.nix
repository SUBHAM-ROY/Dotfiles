{
  pkgs,
  lib,
  config,
  osConfig ? null,
  ...
}:

let
  isNixOS = osConfig != null;
in
{
  imports = [
    ./fish/fish.nix
    ./fastfetch/fastfetch.nix
    ./kitty/kitty.nix
    ./tmux/tmux.nix
    ./ripgrep/ripgrep.nix
    ./fzf/fzf.nix
    ./lazygit/lazygit.nix
    ./yazi/yazi.nix
    ./btop/btop.nix
    ./mangohud/mangohud.nix
    ./neovim/neovim.nix
    ./aerospace/aerospace.nix
    ./aria2/aria2.nix
    ./packages/devtools.nix
    ./packages/utils.nix
    ./packages/misc.nix
  ]
  ++ lib.optional isNixOS [
    ./kde/kde.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage. Username + home directory are platform-dependent so we derive them
  # from pkgs.stdenv at build time instead of hardcoding.
  home.username = if pkgs.stdenv.isLinux then "sroy" else "subham.roy";
  home.homeDirectory = if pkgs.stdenv.isLinux then "/home/sroy" else "/Users/subham.roy";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sroy/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    NH_HOME_FLAKE = "${config.home.homeDirectory}/dotfiles/nix/.config/home-manager";
    NH_OS_FLAKE = "${config.home.homeDirectory}/dotfiles/nix/nixos";
    FLAKE =
      if isNixOS then
        "${config.home.homeDirectory}/dotfiles/nix/nixos"
      else
        "${config.home.homeDirectory}/dotfiles/nix/.config/home-manager";

    # Hint Electron apps to use Wayland
    NIXOS_OZONE_WL = "1";
  };

  home.sessionPath = [
    "$HOME/.nix-profile/bin"
    "/nix/var/nix/profiles/default/bin"
  ];

  # Disable news
  news.display = "silent";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This generates ~/.config/nix/nix.conf, which overrides /etc/nix/nix.conf.
  nix.package = lib.mkIf (!isNixOS) pkgs.nix;
  nix.settings = lib.mkIf (!isNixOS) {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    warn-dirty = false;
  };

  # List of unfree packages that are allowed to be installed.
  nixpkgs = lib.mkIf (!isNixOS) {
    config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "obsidian"
        "stremio-linux-shell"
        "albert"
        "ouch"
        "unrar"
      ];
  };

  programs.zoxide = {
    enable = true;
  };

  programs.nh = {
    enable = true;
  };

  targets.genericLinux.enable = lib.mkIf (!isNixOS && pkgs.stdenv.isLinux) true;
}
