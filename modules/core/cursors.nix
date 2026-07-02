{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      whitesur-cursors
	];

	variables = {
	  XCURSOR_THEME = "WhiteSur-cursors";
	  XCURSOR_SIZE = "24";
	};
  };
}
