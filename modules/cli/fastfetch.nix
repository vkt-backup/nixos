{ pkgs, user, ... }:

{
  environment.systemPackages = with pkgs; [
    fastfetch
  ];

  home-manager.users.${user} = { config, ... }: {
	home.file.".config/fastfetch/config.jsonc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/fastfetch/config.jsonc";
  };
}
