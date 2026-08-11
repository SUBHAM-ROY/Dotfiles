{
  description = "Nix and Home Manager configuration of sroy";

  inputs = {
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
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs =
    { nixpkgs, home-manager, plasma-manager, grub2-themes, nix-flatpak, ... }@inputs:
    let
      mkHomeConfig = system: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home-manager/home.nix
          plasma-manager.homeModules.plasma-manager
        ];
      };
    in
    {
      nixosConfigurations.roynix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./os/configuration.nix
          grub2-themes.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };

      homeConfigurations = {
        "sroy" = mkHomeConfig "x86_64-linux";
        "subham.roy" = mkHomeConfig "aarch64-darwin";
      };
    };
}
