{ pkgs, user, ... }:

{
  environment.systemPackages = with pkgs; [
    foot
  ];

  home-manager.users.${user} = { config, ... }: {
    home.file.".config/foot".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/foot";
  };
}
