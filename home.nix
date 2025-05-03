{ config, pkgs, ... }:

let
  dotfilesDir = ./.;

  excludedNames = [
    "flake.nix"
    "flake.lock"
    "home.nix"
    "configuration.nix"
    "hardware-configuration.nix"
    ".git"
  ];

  isValidEntry = name: type:
    !(builtins.elem name excludedNames);

  listDotfiles = path:
    let
      entries = builtins.readDir path;
      validNames = builtins.attrNames (builtins.filterAttrs isValidEntry entries);
    in
      builtins.concatLists (builtins.map (name:
        let
          fullPath = "${path}/${name}";
        in
          if entries.${name} == "directory" then
            listDotfiles fullPath
          else
            [ fullPath ]
      ) validNames);

  relativePath = fullPath:
    let
      rel = pkgs.lib.removePrefix (toString dotfilesDir + "/") (toString fullPath);
    in ".${rel}";

  dotfiles = listDotfiles dotfilesDir;
in {
  home.username = "yourname";
  home.homeDirectory = "/home/yourname";
  home.stateVersion = "23.11";

  home.file = builtins.listToAttrs (builtins.map (path: {
    name = relativePath path;
    value.source = path;
  }) dotfiles);
}