{ user, ... }:

{
  home-manager.users.${user} = { config, ... }: {
    home.file."Imagens/Wallpapers".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/wallpapers";
  };
}
