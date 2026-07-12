{ pkgs, inputs, user, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  imports = [
    ../apps/nautilus.nix
  ];

  environment.systemPackages = with pkgs; [
    hypridle
    hyprshutdown
    matugen
    wl-clipboard
    cliphist
    wljoywake
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    nwg-look
    adw-gtk3
    adwaita-icon-theme
    kdePackages.qt6ct
    kdePackages.qtwayland
    kdePackages.breeze
    kdePackages.breeze-icons
    kdePackages.qtstyleplugin-kvantum
    grim
    slurp
    swappy
	glib
  ];

  home-manager.users.${user} = { config, ... }: {
    home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/hypr";

    home.file.".config/noctalia".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/noctalia";

    home.file.".local/state/noctalia/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/noctalia/settings.json";

    home.file.".config/qt6ct/qt6ct.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/hypr/qt/qt6ct.conf";

    home.file.".config/qt5ct/qt5ct.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/hypr/qt/qt6ct.conf";

    home.file.".config/kdeglobals".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/hypr/qt/kdeglobals";

    #home.file.".config/gtk-3.0/settings.ini".text = ''
    #[Settings]
    #gtk-theme-name=adw-gtk3-dark
    #gtk-icon-theme-name=Adwaita
    #gtk-decoration-layout=appmenu:close
    #'';

    #home.file.".config/gtk-4.0/settings.ini".text = ''
    #[Settings]
    #gtk-decoration-layout=appmenu:close
    #'';

    gtk = {
      enable = true;

      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };

      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };

      gtk3.extraConfig = {
        gtk-decoration-layout = "appmenu:none";
      };

      gtk4.extraConfig = {
        gtk-decoration-layout = "appmenu:none";
      };

      #cursorTheme = {
      #  name = "whitesur-cursors";
      #  package = pkgs.whitesur-cursors;
      #};
    };
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "breeze";
    XDG_CURRENT_DESKTOP = "Hyprland";
	XDG_SESSION_DESKTOP = "Hyprland";
	XDG_SESSION_TYPE = "wayland";
	DESKTOP_SESSION = "hyprland";
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "breeze";
  };
 
  xdg.portal = {
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
}
