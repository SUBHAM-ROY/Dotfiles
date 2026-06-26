{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
  };
  services.desktopManager.plasma6.enable = true;

  # Enable flatpak
  services.flatpak = {
    enable = true;
    update.onActivation = true;
    packages = [
      "com.heroicgameslauncher.hgl"
      "com.github.tchx84.Flatseal"
      "org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/25.08"
    ];
    overrides = {
      "com.heroicgameslauncher.hgl" = {
        Environment = {
          MANGOHUD = "1";
          MANGOHUD_CONFIGFILE = "${config.users.users.sroy.home}/.config/MangoHud/mango.conf";
        };
      };
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # NVIDIA video drivers
  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;

  # Samba file sharing
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      share = {
        comment = "Roynix Samba Share";
        path = "${config.users.users.sroy.home}/Samba";
        "create mask" = "0644";
        "directory mask" = "0644";
        "valid users" = "sroy";
      };
    };
  };

  # Enable tailscaled
  services.tailscale.enable = true;

  # Navidrome music streaming server
  services.navidrome = {
    enable = true;
    environmentFile = "/var/lib/navidrome/env";
    settings = {
      MusicFolder = "/srv/music";
      Address = "0.0.0.0";
    };
  };

  # Intel thermal daemon
  services.thermald.enable = true;

  # RTKit (required by PipeWire)
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
