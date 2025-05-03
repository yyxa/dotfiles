{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    yandex-browser.url = "github:miuirussia/yandex-browser.nix";
    yandex-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, yandex-browser, ... }@inputs: {
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