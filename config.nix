{
  pkgs,
  user,
  ...
}:

{
  imports = [ ./nixosModules ];

  nix.settings = {
    accept-flake-config = true;
    auto-optimise-store = true;
    builders-use-substitutes = true;
    warn-dirty = false;
    trusted-users = [
      "root"
      "@wheel"
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs.config.allowUnfree = true;
  zramSwap.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    libinput.enable = true;
    udisks2.enable = true;
    xserver.enable = false;
    pipewire.enable = true;
  };

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
    };

    plymouth.enable = true;

    # enable silent boot
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  networking = {
    hostName = "${user.host}";
    networkmanager.enable = true;
  };

  hardware.bluetooth.enable = true;
  time.timeZone = "Asia/Kolkata";

  users.users.${user.name} = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "NetworkManager"
      "wheel"
      "plugdev"
      "adbusers"
    ];
  };

  virtual.enable = true;

  programs.nh = {
    enable = true;
    flake = "/home/${user.name}/nixcfg";
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep 3";
    };
  };

  programs = {
    adb.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    fish.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    aria2
    btop
    curl
    fastfetch
    fzf
    git
    p7zip
    speedtest-rs
    tlrc
    wget
  ];

  system.stateVersion = "24.05";
}