{ user, ... }:

{
  imports = [
    ../../profiles/base.nix
    ../../modules/editors/neovim.nix
    ./hardware-configuration.nix
    ./configuration.nix
  ];

  networking.hostName = "vm-nixos";
}
