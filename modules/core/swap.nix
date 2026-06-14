{ ... }:

{
  swapDevices = [
    {
      device = "/swap/swapfile";
      discardPolicy = "once";
    }
  ];
}
