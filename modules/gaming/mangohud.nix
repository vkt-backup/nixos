{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mangohud
	goverlay
  ];
}
