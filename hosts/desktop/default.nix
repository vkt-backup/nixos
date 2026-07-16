{ ... }:

{
  imports = [
    ../../profiles/base.nix
    #../../profiles/virtualization.nix
    ../../modules/editors/neovim.nix
    #../../modules/desktops/plasma.nix
    ../../modules/desktops/hyprland.nix
    ../../modules/browsers/firefox.nix
	./hardware-configuration.nix
  ];

  networking.hostName = "nix-desktop";
  system.stateVersion = "26.05";
}
