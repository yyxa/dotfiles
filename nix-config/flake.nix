{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # murglar-nix = {
    #   url = "path:/home/yyxa/projects/murglar-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    #quickshell = {
    #  url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    # android-nixpkgs.url = "github:tadfisher/android-nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      # config = {
      #   allowUnfree = true;
      #   android_sdk.accept_license = true;
      # };
    };
  in {
    nixosConfigurations.yyxa = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ 
        ./configuration.nix 
        ./hardware-configuration.nix
      ];
      specialArgs = { inherit inputs; };
    };

    # devShells.${system} = {
    #   rust = import ./shells/rust.nix { inherit pkgs; };
    #   cpp = import ./shells/cpp.nix { inherit pkgs; };
    #   python = import ./shells/python.nix { inherit pkgs; };
    #   murglar-android = import ./shells/murglar-android.nix { inherit pkgs; };
    # };
  };
}