{ config, lib, pkgs, inputs, ... }:

let
  #mt7902-bt = pkgs.callPackage ./pkgs/mt7902-bt.nix {
  #    inherit (config.boot.kernelPackages) kernel;
  #};
  music-presence = pkgs.callPackage ./pkgs/music-presence.nix {};
in { 
	imports = [
      ./hardware-configuration.nix
	  ./fastfetch.nix
	  inputs.nix-flatpak.nixosModules.nix-flatpak
    ];

  boot.loader.limine = {
    enable = true;

    efiSupport = true;

    style = {
      wallpapers = [ ./assets/fallout_limine_background.png ];

      graphicalTerminal = {
        foreground = "189017";
		palette = "189017;189017;189017;189017;189017;189017;189017;189017";

		brightPalette = "6CE974;6CE974;6CE974;6CE974;6CE974;6CE974;6CE974;6CE974";

        brightForeground = "6CE974";
      };
    };

    extraEntries = ''
	/Windows
	    protocol: efi
	    path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
	    comment: Windows 11
    '';
  };

  # configuration.nix - remove vagrant e ansible daqui

#  specialisation = {
#    vbox.configuration = {
#      boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_12;
#      boot.extraModulePackages = lib.mkForce [];
#      boot.kernelModules = lib.mkForce [ "ntsync" ]; # remove btusb e btmtk
#      virtualisation.virtualbox.host.enable = true;
#      environment.systemPackages = with pkgs; [ vagrant ];
#    };
#  };

  hardware.bluetooth = {
	enable = true;
	powerOnBoot = false;
  };

  #hardware.uinput.enable = true;

  services.blueman.enable = true;

  boot.loader.efi.canTouchEfiVariables = true;

  boot.consoleLogLevel = 3;

  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "udev.log_level=3"
    "vt.global_cursor_default=0"
    "amdgpu.dc=1"
  ];

  boot.initrd.verbose = false;

  boot.loader.limine.maxGenerations = 3;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  #boot.extraModulePackages = [ mt7902-bt ];

  boot.plymouth = {
    enable = true;

    theme = "green_blocks";

    themePackages = with pkgs; [ 
      (adi1090x-plymouth-themes.override {
      	selected_themes = [ "green_blocks" ];
      })
    ];
  };
  
  boot.kernelModules = [ "ntsync" "btusb" "btmtk" ];

  boot.blacklistedKernelModules = [ ];

  networking.hostName = "nixos-victor";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";

  swapDevices = [
	{
		device = "/swap/swapfile";
		discardPolicy = "once";
	}
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  i18n = {
    defaultLocale = "pt_BR.UTF-8";
    supportedLocales = [
      "pt_BR.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  
    extraLocaleSettings = {
      LC_ALL = "pt_BR.UTF-8";
    };
  };
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;

    extraConfig.pipewire."99-sample-rate" = {
      "context.properties" = {
        "default.clock.rate" = 44100;
        "default.clock.allowed-rates" = [ 44100 48000 ];
      };
    };
  };


  services.flatpak = {
    enable = true;

    remotes = [
	  {
	    name = "flathub";
		location = "https://flathub.org/repo/flathub.flatpakrepo";
	  }
      {
        name = "trinity";
        location = "https://github.com/Trinity-LA/Trinity-Launcher/releases/download/flatpak/com.trench.trinity.launcher.flatpakrepo";
      }
	];
	
	packages = [
	  "org.vinegarhq.Sober"
	];
  };

  services.udev.extraRules = '' 
  KERNEL=="hidraw*", ATTRS{idVendor}=="fffe", ATTRS{idProduct}=="0087", MODE="0660", GROUP="input"
  ''; 

  services.libinput = {
    enable = true;
  
    mouse = {
      accelProfile = "flat";
      accelSpeed = "-0.5";
    };
  };

  myModules.fastfetch.enable = true;

  programs.silentSDDM = {
    enable = true;
	theme = "rei";

	backgrounds = {
		city = ./assets/city.mp4;
	}; 

	settings = { 
	  "LockScreen" = { 
		  background = "city.mp4"; 
      };

      "LoginScreen" = {
        background = "city.mp4";
      };

      "General" = {
        background = "city.mp4";
      };
	};
  };

  services.displayManager.sddm = {
    enable = true;

    wayland = {
      enable = true;
      compositor = "kwin";
    };

	settings = {

	  Theme = {
        CursorTheme = "WhiteSur-cursors";
        CursorSize = 24;
	  };
	};
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  
  services.zerotierone = {
    enable = true;
    joinNetworks = [
	  "76fc96e498f27808"
    ];
  };
  #services.xserver.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  #Gaming optimizations
  programs.gamemode.enable = true;

  powerManagement.cpuFreqGovernor = "schedutil";

  boot.kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = 1;
  };

  #users.groups.keyd = {};

  users.users.victor = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "kvm" "video" "input" "networkmanager" ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.bash;
  };

  programs.firefox = { #customize todo
     enable = true;

    languagePacks = [ "pt-BR" "en-US" ];

    preferences = {
      "privacy.resistFingerprinting" = true;
    };

    policies = {
      DisableTelemetry = true;
      HardwareAcceleration = true;
    };
  };

  programs.steam = { #Gaming
    enable = true;
    gamescopeSession.enable = false;
  };

  xdg.portal = { # Hyprland
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    config = {
      common = {
        default = [ "gtk" ];
      };

      hyprland = {
        default = [ "gtk" ];

        "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
      };
    };
  };

  programs.hyprland = { # Hyprland
    enable = true;
    xwayland.enable = true;
  };


  nixpkgs.config.allowUnfree = true;

  virtualisation.libvirtd = {
	enable = true;
	qemu = {
	  package = pkgs.qemu_kvm;
	  runAsRoot = true;
	  swtpm.enable = true;
	  #ovmf.enable = true;
	};
  };
  virtualisation.libvirtd.allowedBridges = [ ];

  networking.firewall.trustedInterfaces = [ "virbr0" ];

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      #noto-fonts-cjk
      nerd-fonts.jetbrains-mono
      nerd-fonts.comic-shanns-mono
	  freetype
      dejavu_fonts
    ];
  };

  environment.variables = {
    XCURSOR_THEME = "WhiteSur-cursors";
    XCURSOR_SIZE = "24";
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "breeze";
  };

  qt = {
    enable = true; 
    platformTheme = "qt5ct"; 
    style = "breeze"; 
  };

 # qt = {
 #   enable = true;
 #   platformTheme = "qt6ct";
 #   style = "kvantum";
 # };

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  programs.nix-ld = {
    enable = true;

	libraries = with pkgs; [
      bzip2
	];
  };

  environment.systemPackages = with pkgs; [
    #Shell utilities feito
    bash
    git
    eza
    bat
    zsh 
    starship
    wget
    ripgrep
	lavat
	jq
	socat

	#Proton
	proton-pass

	#Browsers
	qutebrowser
	chromium

	#App Image
	appimage-run

	#Moonlight
	moonlight-qt

    #Hyprland utilities feito
	hyprshutdown
    hypridle
    matugen
    wl-clipboard
    wljoywake
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    nwg-look
    adw-gtk3
	adwaita-icon-theme
    qt6Packages.qt6ct
	qt6.qtwayland
	kdePackages.breeze
	kdePackages.breeze-icons
    kdePackages.qtstyleplugin-kvantum
    grim
    slurp
    swappy
    cliphist

    kdePackages.dolphin 
    neovim
	unzip
    foot
    music-presence
	distrobox

	#LLMs locais
	lmstudio

	#Cursor fetio
	whitesur-cursors

    #Other
    krita

    #SDDM
    kdePackages.sddm-kcm
    kdePackages.kwin

    #games feito
    protonup-qt
	protontricks
	zerotierone
	gamescope
	mangohud
	goverlay
	heroic
	#lutris

    #Programing
	posting

	#Programing languages todo
	gcc
	clang
	clang-tools
	rustc
	cargo
	typescript

	#LSPs todo
	nixd
	lua-language-server
	clang-tools
	rust-analyzer
	tree-sitter
	vscode-langservers-extracted
	typescript-language-server
	astro-language-server
	jdt-language-server


    #Codecs de video todo
    ffmpeg-full
    #gstreamer
    vlc
	mpv
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav

    #Áudio verificar
    pipewire
    wireplumber

    #Bluetooth verificar
    bluez
    bluez-tools

    #Docker e VMS verificar
    docker
    docker-compose
    virt-manager
    qemu_full
	dnsmasq

    #Btop gpu driver feito
	rocmPackages.rocm-smi

    #Apps
    discord
    prismlauncher
    (btop.override { rocmSupport = true; })
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

  #services.keyd = {
  #  enable = true;

  #  keyboards = {
  #    default = {
  #      ids = [ "*" ];
  #  	
  #  	extraConfig = ''
  #  	  [main]
  #  	  rightalt = layer(ralt)

  #  	  [ralt]
  #  	  j = down
  #  	  k = up
  #  	  h = left
  #  	  l = right
  #  	'';
  #    };
  #  };
  #};

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22000 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "25.11";

}
