{
  description = "NixOS configuration of sroy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    grub2-themes.url = "github:vinceliuice/grub2-themes";
  };

  outputs =
    inputs@{ nixpkgs, grub2-themes, ... }:
    {
      nixosConfigurations.roynix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          grub2-themes.nixosModules.default
        ];
      };
    };
}
