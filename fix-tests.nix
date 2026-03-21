{ pkgs ? import <nixpkgs> {} }:
let
  tree = import (fetchTarball "https://github.com/vic/import-tree/archive/master.tar.gz") ./modules;
in tree
