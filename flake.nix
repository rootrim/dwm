{
  description = "dwm flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.dwm = pkgs.stdenv.mkDerivation {
        pname = "dwm";
        version = "6.8.1";

        src = ./.;

        buildInputs = [ pkgs.xorg.libX11 pkgs.makeWrapper ];
        installPhase = ''
          mkdir -p $out/bin
          make
          cp dwm $out/bin/
        '';
      };
    };
}
