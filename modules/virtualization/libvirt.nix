{ pkgs, user, ... }:

{
  environment.systemPackages = with pkgs; [
    virt-manager 
	qemu_full
	dnsmasq
  ];

  virtualisation.libvirtd = {
    enable = true;

	qemu = {
      package = pkgs.qemu_kvm;
	  runAsRoot = true;
	  swtpm.enable = true;
	};

	allowedBridges = [ ];
  };

  networking.firewall.trustedInterfaces = [ "virbr0" ];

  users.users.${user}.extraGroups = [ "libvirtd" "kvm" ];
}
