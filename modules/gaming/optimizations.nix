{ ... }:

{
  programs.gamemode = {
    enable = true;
	settings = {
      general = {
        renice = 10;
      };
	};
  };

  powerManagement.cpuFreqGovernor = "schedutil";
}
