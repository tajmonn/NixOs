{pkgs, ... }:

{
  # Use bash as default shell
  programs.bash = {
    enable = true;
  };

  # Enable SSH client and config support 
  programs.ssh = {
    enable = true;
  };

  # Essential packages for work user
  home.stateVersion = "24.11"; 
  home.packages = with pkgs; [
    openssh
    remmina
  ];


  # Enable some sytemd user services, e.g. for ssh-agent
  services = {
    ssh-agent.enable = true;
  };

}