{
  description = "Home Manager configuration of sroy";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    { nixpkgs, home-manager, plasma-manager, ... }:
    let
      mkConfig =
        system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};

          modules = [
            ./home.nix
            plasma-manager.homeModules.plasma-manager
          ];
        };
    in
    {
      homeConfigurations = {
        "sroy" = mkConfig "x86_64-linux";
        "subham.roy" = mkConfig "aarch64-darwin";
      };
    };
}
