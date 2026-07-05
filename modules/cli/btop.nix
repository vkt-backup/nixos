{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
	rocmPackages.rocm-smi
	(btop.override { rocmSupport = true; })
  ];
}
