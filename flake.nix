{
  description = "dwm flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      dwm = pkgs.stdenv.mkDerivation {
        pname = "dwm";
        version = "6.8.1";
        src = ./.;

        nativeBuildInputs = with pkgs; [ pkg-config gcc gnumake ];
        buildInputs = with pkgs; [
          libX11
          libXinerama
          libXft
          freetype
          fontconfig
        ];

        buildPhase = ''
          make CC=gcc
        '';

        installPhase = ''
          mkdir -p $out/bin
          cp dwm $out/bin/
        '';

      };

      devShell = pkgs.mkShell { nativeBuildInputs = with pkgs; [ bear ]; };

      defaultPackage.${system} = self.dwm;
    };
}
