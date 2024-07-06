{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";

    ocaml-overlays.url = "github:nix-ocaml/nix-overlays";
    ocaml-overlays.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    systems,
    nixpkgs,
    ocaml-overlays,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;

    eachSystem = f:
      nixpkgs.lib.genAttrs (import systems) (
        system: let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ocaml-overlays.overlays.default];
          };
        in
          f
          {
            inherit pkgs system;
            ocamlPackages = pkgs.ocaml-ng.ocamlPackages_latest.overrideScope' (oself: _osuper: {
              quickjs = oself.buildDunePackage {
                name = "quickjs";
                pname = "quickjs";
                version = "n/a";
                src = pkgs.fetchFromGitHub {
                  owner = "ml-in-barcelona";
                  repo = "quickjs.ml";
                  rev = "86aad3d9d8b2485b50b7dd1046aaf7e7628cbf45";
                  sha256 = "sha256-+XW31KOcANL7irogZTno9bWKmCTnJf7cgEvT0JfoNsQ=";
                  fetchSubmodules = true;
                };
                propagatedBuildInputs = with oself; [
                  integers
                  ctypes
                  alcotest
                  fmt
                ];
                nativeBuildInputs = with oself; [
                  ocaml
                ];
              };
            });
          }
      );
  in {
    ocamlPackages = eachSystem ({ocamlPackages, ...}: ocamlPackages);

    packages = eachSystem ({
      pkgs,
      ocamlPackages,
      ...
    }: {
      default = ocamlPackages.buildDunePackage {
        pname = "server-reason-react";
        version = "n/a";

        duneVersion = "3";

        src = self.outPath;

        propagatedBuildInputs = with ocamlPackages; [
          melange
          ppxlib
          reason
          ocaml_pcre
          lwt
          lwt_ppx
          uri
          quickjs
          integers
          reason-react-ppx
          reason-react
          alcotest-lwt
          tiny_httpd
          melange-webapi
        ];

        nativeBuildInputs = with ocamlPackages; [
          reason
          melange
          reason-native.refmterr
        ];
      };
    });

    devShells = eachSystem ({
      pkgs,
      ocamlPackages,
      ...
    }: {
      default = pkgs.mkShell {
        inputsFrom = [self.packages.${pkgs.system}.default];
        buildInputs =
          lib.optional pkgs.stdenv.isLinux pkgs.inotify-tools
          ++ (with ocamlPackages; [
            ocaml-lsp
            ocamlformat
            ocp-indent
            utop
            # Needed for generating documentation
            opam
            odoc
            odig
            # (sherlodoc.override {enableServe = true;})
          ]);
      };
    });
  };
}
