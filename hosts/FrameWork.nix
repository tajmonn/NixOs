{config, pkgs, ...}:

{

  # Set Hostname
  networking.hostName = "FrameWork";

  # Timezone and locale
  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  # Users and groups (basic, more user config done in home-manager)
  users.users.tymon = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "networkmanager" ]; # wheel for sudo, video for graphics, networkmanager for networkmanager :)
    shell = pkgs.zsh;
    # home = "home/tymon"; # default so not needed
  };

  users.users.work = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "networkmanager" ];
    shell = pkgs.bash;
    # home = "home/work"; # deafult so not needed
  };

  # Enable sudo for wheel group
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Enable X11 and Wayland support 
  services.xserver.enable = true;

  # Display manager (login screen)
  services.displayManager.sddm.enable = true;

  # Fonts 
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerdfonts.FiraCode
    nerdfonts.JetBrainsMono
    nerdfonts.Hack
    nerdfonts.Iosevka
  ];

  # Enable Pipewire for audio 
  services.pipewire.enable = true;

  # Firewall - basic
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [22 3389]; # SSH and RDP ports open

  # Filesystems
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5ed6ad0e-502f-45bb-9d6b-2bbd7f19ed02";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/335C-534F";
    fsType = "vfat";
  };

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Swap
  swapDevices = [
    { device = "/dev/disk/by-uuid/1c4d2c61-4abd-4253-a109-93a727a29366"; }
  ];




}