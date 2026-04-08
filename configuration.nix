{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos-victor";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  i18n.defaultLocale = "pt_BR.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  users.users.victor = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.bash;
  };

  programs.firefox = {
    enable = true;

    languagePacks = ["pt-BR" "en-US"];

    preferences = {
      "privacy.resistFingerprinting" = true;
    };

    policies = {
      DisableTelemetry = true;
      HardwareAcceleration = true;
    };
  };

  programs.steam = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ pkgs.xdg-desktop-portal-hyprland ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };


  nixpkgs.config.allowUnfree = true;

  #virtualization.libvirtd.enable = true;

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      #noto-fonts-cjk
      nerd-fonts.jetbrains-mono
      nerd-fonts.comic-shanns-mono
    ];
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_STYLE_OVERRIDE = "kvantum";
  };

  environment.systemPackages = with pkgs; [
    #Shell utilities
    bash
    git
    eza
    bat
    zsh
    starship
    wget

    #Hyprland utilities
    hypridle
    matugen
    wl-clipboard
    wljoywake
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    nwg-look
    qt6Packages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    grim
    slurp
    swappy
    cliphist

    neovim
    foot

    #Codecs de video
    ffmpeg-full
    #gstreamer
    vlc
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav

    #Áudio
    pipewire
    wireplumber

    #Bluetooth
    bluez
    bluez-tools

    #Docker e VMS
    docker
    docker-compose
    #virt-manager
    #qemu_full
    #dnsmasq

    #Apps
    discord
    prismlauncher
    btop
    obs-studio
    onlyoffice-desktopeditors
    godot
    qbittorrent
    yazi
    nautilus
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "25.11";

}
