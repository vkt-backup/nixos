{ config, ... }:

{
  imports = [
    ../modules/core/bootloader.nix
	../modules/core/bluetooth.nix
	../modules/core/audio.nix
	../modules/core/user.nix
	../modules/core/swap.nix
	../modules/desktops/sddm.nix
	../modules/shell/zsh.nix
	../modules/shell/yazi.nix
	../modules/shell/git.nix
	../modules/shell/ripgrep.nix
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
}
