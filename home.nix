{ config, pkgs, ... }: 

let
  configDir = "/home/victor/nixos/config";
in
{
  home.username = "victor";
  home.homeDirectory = "/home/victor";
  home.stateVersion = "25.11";
  #home.file.".config/hypr".source = ./config/hyprland-config;
  home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/hyprland-config";
  home.file.".config/foot".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/foot";
  home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/zsh/.zshrc";
  home.file.".config/zsh/plugins".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/zsh/plugins";
  home.file.".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/starship/starship.toml";
  home.file."Imagens/Wallpapers".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/Wallpapers";
  home.file."scripts/".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/scripts";
  home.file.".config/noctalia".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/noctalia";
  home.file.".config/fastfetch/config.jsonc".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/fastfetch/custom.jsonc";

  gtk = {
    enable = true;

	gtk4.theme = config.gtk.theme;

	theme = {
      name = "adw-gtk3-dark";
	  package = pkgs.adw-gtk3;
    };

    iconTheme = { 
	  name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

	cursorTheme = {
	  name = "WhiteSur-cursors";
	  package = pkgs.whitesur-cursors;
	};
  };
}
