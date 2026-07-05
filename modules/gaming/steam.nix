{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
	enable32Bit = true;
  };

  programs.steam = {
    enable = true;
	remotePlay.openFirewall = true;
	dedicatedServer.openFirewall = false;
	gamescopeSession.enable = false;
  };

  environment.systemPackages = with pkgs; [
    gamescope
	protonup-qt
  ];
}
