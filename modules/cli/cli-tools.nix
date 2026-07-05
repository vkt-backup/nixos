{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ripgrep
	eza
	bat
	wget
	fzf
	lavat
	unzip
    gnutar
	p7zip
  ];
}
