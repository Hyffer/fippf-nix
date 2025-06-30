{ pkgs ? import <nixpkgs> {} }:

let
  fippf = pkgs.callPackage ./default.nix {};
in
pkgs.dockerTools.buildImage {
  name = "fippf";
  tag = fippf.version;

  copyToRoot = pkgs.buildEnv {
    name = "image-root";
    paths = [ fippf ];
    pathsToLink = [ "/bin" ];
  };

  config = {
    Cmd = [ "fippf" "serve" ];
  };
}
