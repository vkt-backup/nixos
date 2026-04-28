{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, noctalia, ... }: {
    nixosConfigurations.nixos-victor = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
	    home-manager.nixosModules.home-manager {
	      home-manager = {
	        useGlobalPkgs = true;
	        useUserPackages = true; 
	        users.victor = import ./home.nix;
	        backupFileExtension = "backup";
	      };
	    }
	    inputs.silentSDDM.nixosModules.default
      ];
    };
  };
}
