{ inputs, pkgs, ... }:

{
  programs.silentSDDM = {
    enable = true;
    theme = "rei";

	backgrounds = {
	  city = ../../assets/nixos.jpg;
	};

	settings = {
      "LockScreen".background = "nixos.jpg";
	  "LoginScreen".background = "nixos.jpg";
	  "General".background = "nixos.jpg";
	};
  };

  services.displayManager.sddm = {
    enable = true;

    wayland = {
      enable = true;
      compositor = "kwin";
    };

    settings.Theme = {
      CursorTheme = "WhiteSur-cursors";
      CursorSize = 24;
    };
  };
}
