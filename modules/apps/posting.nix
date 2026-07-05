{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    posting
  ];
}
