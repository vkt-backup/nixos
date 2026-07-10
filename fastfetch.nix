{ config, lib, pkgs, ... }: 

let
  cfg = config.myModules.fastfetch;
in 
{
	options.myModules.fastfetch.enable = lib.mkEnableOption "fastfetch";

	config = lib.mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			fastfetch	
		];
	};
}
