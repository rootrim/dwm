{
  description = "dwm flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system} = {
        dwm = pkgs.stdenv.mkDerivation {
          pname = "dwm";
          version = "6.8.1";
          src = ./.;

          nativeBuildInputs = with pkgs; [ pkg-config zig ];
          buildInputs = with pkgs; [
            libx11
            libxinerama
            libxft
            freetype
            fontconfig
          ];

          buildPhase = ''
            export ZIG_GLOBAL_CACHE_DIR=$(mktemp -d)
            make CC="zig cc"
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp dwm $out/bin/
          '';

        };
        default = self.packages.${system}.dwm;
      };

      devShell = pkgs.mkShell { nativeBuildInputs = with pkgs; [ bear ]; };

      defaultPackage.${system} = self.packages.${system}.dwm;
    };
}
