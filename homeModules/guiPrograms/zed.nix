{
  lib,
  pkgs,
  user,
  ...
}:

{
  programs.zed-editor = {

    enable = true;
    package = pkgs.zed-editor;
    extraPackages = [ pkgs.nixd ];
    extensions = [ "nix" ];

    userSettings = {
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_fallbacks = [ "Nerd Font" ];
      buffer_font_size = 16;
      buffer_font_weight = 400; # between 100 and 900
      languages.Nix = {
        language_servers = [
          "nixd"
          "!nil"
        ];
        formatter.external.command = "${lib.getExe pkgs.nixfmt-rfc-style}";
      };
      lsp.nixd.settings = {
        nixpkgs.expr = "import (builtins.getFlake \"/home/${user.name}/nixcfg\").inputs.nixpkgs { }   ";
        options = {
          nixos.expr = "(builtins.getFlake \"/home/${user.name}/nixcfg\").nixosConfigurations.${user.host}.options";
          home_manager.expr = "(builtins.getFlake \"/home/${user.name}/nixcfg\").nixosConfigurations.${user.host}.options.home-manager.users.type.getSubOptions []";
        };
        diagnostic.suppress = [ "sema-extra-with" ];
      };
    };

  };
}