{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      #noto-fonts-cjk
      nerd-fonts.jetbrains-mono
      nerd-fonts.comic-shanns-mono
      freetype
      dejavu_fonts
    ];
  };
}
