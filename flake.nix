{
  description = "Main Flake configuration for EdleyIT";

  inputs = {
    # NixOS official package source, using the unstable and nixos-25.05 branch here
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # Declarative Flatpaks
    # nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # Enable Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      hostname = "lenovo-t470";
      system = "x86_64-linux";
    in {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit hostname;
        };
        system = system;

        modules = [
          ./hosts
          ./desktops

          # Configure system users
          ./users
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };

}
