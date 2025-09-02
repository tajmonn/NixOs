{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # papirus-icon-theme
  ];

  fonts = {
    packages = with pkgs; [
      roboto
      inter

      comic-neue
 
      work-sans
      source-sans
 
      material-symbols

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji

      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.meslo-lg
    ];

    enableDefaultPackages = false;
  };
}
