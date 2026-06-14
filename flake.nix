{
  description = "Dendritic config for Veketi's systems!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

	silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
	  inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = inputs@{ self, nixpkgs, home-manager, silentSDDM, ... }: 
  let
    user = "victor";

    homeManagerModule = {
      imports = [ home-manager.nixosModules.home-manager ];
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
	
	    users.${user} = {
	      home.username = user;
	      home.homeDirectory = "/home/${user}";
	      home.stateVersion = "26.11";
	    };
      };
    };

	silentSddmModule = {
		imports = [ silentSDDM.nixosModules.default ];
	};
  in
  {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit user; };
	modules = [
          homeManagerModule
		  silentSddmModule
          ./hosts/desktop
        ];
      };

      vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit user; };
        modules = [
          homeManagerModule
		  silentSddmModule
          ./hosts/vm
        ];
      };
    };
  };
}
