# xwayland-satellite
xwayland-satellite grants rootless Xwayland integration to any Wayland compositor implementing xdg_wm_base.
This is particularly useful for compositors that (understandably) do not want to go through implementing support for rootless Xwayland themselves.

## Dependencies
- Xwayland >=23.1
- xcb
- xcb-util-cursor
- clang (building only)

## Usage
Run `xwayland-satellite`. You can specify an X display to use (i.e. `:12`). Be sure to set the same `DISPLAY` environment variable for any X11 clients.
Because xwayland-satellite is a Wayland client (in addition to being a Wayland compositor), it will need to launch after your compositor launches, but obviously before any X11 applications.

## Building
```
cargo build
cargo run
```

## Systemd support
xwayland-satellite can be built with systemd support - simply add `-F systemd` to your build command - i.e. `cargo build --release -F systemd`.  
With systemd support, satellite will send a state change notification when Xwayland has been initialized, allowing for having services dependent on satellite's startup.  
An example service file is located in `resources/xwayland-satellite.service` - be sure to replace the `ExecStart` line with the proper location before using it. It can be placed in a systemd user unit directory (i.e. `$XDG_CONFIG_HOME/systemd/user` or `/etc/systemd/user`), and be launched and enabled with `systemctl --user enable --now xwayland-satellite`. It will be started when the `graphical-session.target` is reached, which is likely after your compositor is started if it supports systemd.

## Nix Flake
You can add the nix flake to your configuration via:
```
xwayland-satellite-flake = {
    url = "github:cspark-development/xwayland-satellite-flake";
};
```

You can then add the `xwayland-satellite` pkg to your environment packages.
