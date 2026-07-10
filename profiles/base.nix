{ user, ... }:

{
  imports = [
    ../modules/core/bootloader.nix
    ../modules/core/bluetooth.nix
    ../modules/core/audio.nix
    ../modules/core/swap.nix
    ../modules/core/cursors.nix
    ../modules/core/codecs.nix
	../modules/core/fonts.nix
    ../modules/hardware/input.nix
    ../modules/users
    ../modules/cli/zsh.nix
    ../modules/cli/yazi.nix
    ../modules/cli/git.nix
    ../modules/cli/fastfetch.nix
    ../modules/cli/starship.nix
    ../modules/cli/cli-tools.nix
    ../modules/cli/btop.nix
    ../modules/desktops/sddm.nix
    ../modules/flatpak
    ../modules/gaming
    ../modules/apps
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  services.openssh.enable = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";

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

  home-manager.users.${user} = { config, ... }: {
    home.file."Imagens/Wallpapers".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/wallpapers";
  };
}
