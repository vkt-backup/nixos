{ user, pkgs, ... }:

{
  users.users."${user}" = {
    isNormalUser = true;
    description = "Victor Botelho Silva";
    extraGroups = [ "wheel" "docker" "libvirtd" "kvm" "video" "input" "networkmanager" ];
	initialPassword = "1234567890";
	shell = pkgs.bash;
  };
}
