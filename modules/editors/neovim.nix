{ user, pkgs, ... }:

{
  home-manager.users.${user} = { config, ... }: {
    home.packages = with pkgs; [ 
	  neovim
      tree-sitter 
	];
    home.sessionVariables.EDITOR = "nvim";

    xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/nvim";
  };
}
