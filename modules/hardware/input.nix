{ ... }: 

{
  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      accelSpeed = "-0.5";
    };
  };
}
