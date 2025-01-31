{
  pkgs,
  user,
  ...
}:

{
  imports = [ ./homeModules ];

  home = {
    username = "${user.name}";
    homeDirectory = "/home/${user.name}";
    stateVersion = "24.05";
  };

  programs = {
    bat.enable = true;
    btop.enable = true;
    imv.enable = true;
    gitui.enable = true;
    mpv.enable = true;
    obs-studio.enable = true;
  };

  home.packages = with pkgs; [
    catppuccinifier-cli
    celluloid
    fragments
    nautilus
    ghostty
    protonvpn-gui
    telegram-desktop
    vesktop
  ];

  programs.home-manager.enable = true;
}
