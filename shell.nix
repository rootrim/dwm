{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    xorg.libX11
    xorg.libXinerama
    xorg.libXft
    freetype
    fontconfig
    bear
    clang
  ];
}

