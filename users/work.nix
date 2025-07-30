{pkgs, ... }:

{
  # Use bash as default shell
  programs.bash = {
    enable = true;
    interactiveShellInit = ''
      # Custom bash promt for work
      PS1='\{\e[32m\]\u@\h:w\$ \[\e[m\]'
    '';
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