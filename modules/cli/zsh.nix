{ user, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
  };

  home-manager.users.${user} = { config, ... }: {
	home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/zsh/.zshrc";
	home.file.".config/zsh/plugins".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/zsh/plugins";
  };
}
