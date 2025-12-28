{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    yandex-browser = {
      url = "github:miuirussia/yandex-browser.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    murglar-nix = {
      url = "path:/home/yyxa/projects/murglar-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #quickshell = {
    #  url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    android-nixpkgs.url = "github:tadfisher/android-nixpkgs";
  };

  outputs = { self, nixpkgs, yandex-browser, murglar-nix, android-nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.yyxa = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ 
        ./configuration.nix 
        ./hardware-configuration.nix
      ];
      specialArgs = { inherit inputs; };
    };

    devShells.${system} = {
      rust = import ./shells/rust.nix { inherit pkgs; };
      cpp = import ./shells/cpp.nix { inherit pkgs; };
      python = import ./shells/python.nix { inherit pkgs; };
      murglar-android = import ./shells/murglar-android.nix { inherit pkgs; };
    };
  };
}