{
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];

  nix.settings = {
    accept-flake-config = true;
    builders-use-substitutes = true;
    warn-dirty = false;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [ "root" ];
  };

  isoImage.isoName = lib.mkForce "nixiso.iso";
  zramSwap.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };

  networking = {
    wireless.enable = false;
    networkmanager.enable = true;
  };

  environment = {
    sessionVariables.EDITOR = "hx";

    systemPackages = with pkgs; [
      aria2
      btop
      btrfs-progs
      curl
      fish
      fzf
      git
      helix
      tlrc
      yazi
    ];
  };

  programs.fish.enable = true;
  users.users.root.shell = pkgs.fish;
}
