{ config, pkgs, ... }: 

{
  boot = {
    loader = {
      limine = {
        enable = true;

        efiSupport = true;

		#maxGenerations = 2;

        style = {
          wallpapers = [ ../../assets/fallout_limine_background.png ];
          
          graphicalTerminal = {
            foreground = "189017";
            palette = "189017;189017;189017;189017;189017;189017;189017;189017";
            
            brightPalette = "6CE974;6CE974;6CE974;6CE974;6CE974;6CE974;6CE974;6CE974";
            
            brightForeground = "6CE974";
          };
        };
      };

      efi.canTouchEfiVariables = true;
    };

    consoleLogLevel = 3;

    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "udev.log_level=3"
      "vt.global_cursor_default=0"
      "amdgpu.dc=1"
    ];

    initrd.verbose = false;

    kernelPackages = pkgs.linuxPackages_latest; 

    plymouth = {
      enable = true;

      theme = "green_blocks";

      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "green_blocks" ];
        })
      ];
    };

    kernelModules = [ "ntsync" ];

    blacklistedKernelModules = [];

    kernel.sysctl = {
      "kernel.unprivileged_userns_clone" = 1;
    };
  };
}
