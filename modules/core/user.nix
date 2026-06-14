{ user, pkgs, ... }:

{
  users.users."${user}" = {
    isNormalUser = true;
    description = "Victor Botelho Silva";
    extraGroups = [ "wheel" "docker" "libvirtd" "kvm" "video" "input" "networkmanager" ];
	shell = pkgs.bash;
  };
}
