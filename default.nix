{ pkgs ? import <nixpkgs> { } }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "xwayland-satellite";
  checkType = "release";
  buildType = "release";
  doCheck = false;
  version = "0.1";
  cargoLock.lockFile = ./Cargo.lock;
  src = pkgs.lib.cleanSource ./.;
  #src = (pkgs.fetchFromGitHub {
  #		owner = "Supreeeme";
  #      	repo = "xwayland-satellite";
  #      	rev = "8892570093948de16a50e06b1a7d6890405de7a1";
  #      	hash = "sha256-zk62B0tIf2SRNCeQnXxatq2gvjtaJ8xp3Hp9RB43xs0=";
  #      }
  #);
  nativeBuildInputs = with pkgs; [ pkg-config clang ];
  buildInputs = with pkgs; [ xwayland xorg.libxcb xcb-util-cursor ];
  preConfigure = ''
      export LIBCLANG_PATH="${pkgs.libclang.lib}/lib";
    '';
  shellHook = ''
      export LIBCLANG_PATH="${pkgs.libclang.lib}/lib";
    '';
}
