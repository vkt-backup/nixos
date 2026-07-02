{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
	storageDriver = "btrfs";
	autoPrune = {
	  enable = true;
	  dates = "monthly";
	};
  };

  environment.systemPackages = with pkgs; [
	docker
	docker-compose
  ];
}
