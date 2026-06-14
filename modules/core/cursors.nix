{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      whitesur-cursors
	];

	varibles = {
	  XCURSOR_THEME = "WhiteSur-cursors";
	  XCURSOR_SIZE = "24";
	}
  };
}
