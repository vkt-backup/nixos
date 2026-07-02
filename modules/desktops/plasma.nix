{ pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
	oxygenfonts
	kdePackages.oxygen
	kdePackages.oxygen-icons
	kdePackages.oxygen-sounds
	klassy
	kdePackages.qtstyleplugin-kvantum
  ];
}
