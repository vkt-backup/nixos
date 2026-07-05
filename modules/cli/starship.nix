{ pkgs, user, ... }:

{
  environment.systemPackages = with pkgs; [
    starship
  ];

  home-manager.users.${user} = { config, ... }: {
	home.file.".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/starship/starship.toml";
  };
}
