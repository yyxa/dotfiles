{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    yandex-browser = {
      url = "github:miuirussia/yandex-browser.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, quickshell, yandex-browser, ... }@inputs: {
    nixosConfigurations.drama = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./configuration.nix 
        ./hardware-configuration.nix
      ];
      specialArgs = { inherit inputs; };
    };
  };
}