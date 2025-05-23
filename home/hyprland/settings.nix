{
  lib,
  pkgs,
  user,
  ...
}:
let
  random-wall = pkgs.writeShellApplication {
    name = "random-wall";
    runtimeInputs = [ pkgs.swww ];
    text = ''
      swww-daemon &

      export SWWW_TRANSITION=center
      export SWWW_TRANSITION_FPS=60
      export SWWW_TRANSITION_STEP=2

      while true; do
        IMAGE=$(find "${user.assets}/wallpapers" -type f | shuf -n 1)
        swww img "$IMAGE"
        sleep "30"
      done
    '';
  };
in
{
  wayland.windowManager.hyprland.settings = {

    "$browser" = "firefox";
    "$terminal" = "kitty";
    "$file" = "$terminal -e yazi";
    "$menu" = "anyrun";
    "$monitor" = "$terminal -e btop";

    monitor = ", 1920x1080@60, 0x0, 1.0";

    exec-once = [
      "clipse -listen"
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      "${lib.getExe random-wall}"
    ];

    env = [
      "GDK_BACKEND,wayland"
      "SDL_VIDEODRIVER,wayland"
      "CLUTTER_BACKEND,wayland"
      "QT_QPA_PLATFORM,wayland"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

      "HYPRCURSOR_THEME,Bibata-Modern-Classic"
      "HYPRCURSOR_SIZE,20"
      "XCURSOR_THEME,Bibata-Modern-Classic"
      "XCURSOR_SIZE,20"

      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"
    ];

    general = {
      border_size = 2;
      gaps_in = 7;
      gaps_out = 15;
      layout = "dwindle";
      "col.active_border" = "$blue";
      "col.inactive_border" = "$crust";
      resize_on_border = true;
    };

    master = {
      mfact = 0.5;
      new_status = "master";
    };

    decoration = {
      rounding = 8;
      rounding_power = 2.0;
      blur = {
        enabled = true;
      };
      shadow.enabled = false;
    };

    input.touchpad = {
      natural_scroll = true;
      drag_lock = true;
      tap-and-drag = true;
    };

    gestures = {
      workspace_swipe = true;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      font_family = "JetBrainsMonoNF-SemiBold";
      vrr = 1;
    };

  };
}
