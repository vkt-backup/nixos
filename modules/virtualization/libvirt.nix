{ pkgs, user, ... }:

{
  virtualization.libvirtd = {
    enable = true;

	qemu = {
      package = pkgs.qemu_kvm;
	  runAsRoot = true;
	  swtpm.enable = true;
	  ovmf.enable = true; #talvez dê problema
	};

	allowedBridges = [];
  };

  environment.systemPackages = with pkgs; [
    virt-manager 
	qemu_full
	dnsmasq
  ];

  networking.firewall.trustedInterfaces = [ "virbr0" ];

  users.${user}.extraGroups = [ "libvirtd" "kvm" ];
}
