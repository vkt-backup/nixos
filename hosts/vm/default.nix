{ user, ... }:

{
  imports = [
    ../../profiles/base.nix
    ../../modules/editors/neovim.nix
    #../../modules/desktops/plasma.nix
    ../../modules/desktops/hyprland.nix
    ../../modules/browsers/firefox.nix
    ./hardware-configuration.nix
    ./configuration.nix
  ];

  networking.hostName = "vm-nixos";
  system.stateVersion = "26.05";
}
