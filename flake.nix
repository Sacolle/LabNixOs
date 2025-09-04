{
  description = "NixOS default config usando hommander";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
    	url = "github:nix-community/home-manager";
	inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
        url = "github:oxalica/rust-overlay";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, rust-overlay, ... }:
    {
      nixosConfigurations = {
        lab205-pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.colle = ./home.nix;

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
	    ({ pkgs, ... }: {
		nixpkgs.overlays = [ rust-overlay.overlays.default ];
		environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
	    })
          ];
        };
      };
    };
}
