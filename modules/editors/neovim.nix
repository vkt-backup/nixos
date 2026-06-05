{ user, ... }:

{
  home-manager.users.${user} = { config, ... }: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
    #assertions = [{
    #  assertion = false;
    #  message = "homeDirectory = ${config.home.homeDirectory}";
    #}];
    #assertions = [{
    #  assertion = false;
    #  message = ''
    #    username=${config.home.username}
    #    home=${config.home.homeDirectory}
    #  '';
    #}];

    xdg.configFile."nvim".source = ../../config/nvim;
  };
}
