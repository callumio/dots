{
  description = "99 with a Flake please :D";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:callumio/nixvim";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, sops-nix
    , firefox-addons, nixvim, ... }@inputs:
    let
      system = "x86_64-linux";
      stateVersion = "24.05";

      unstable-packages = final: _prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit (final) system;
          config.allowUnfree = true;
        };
      };

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [ unstable-packages ];
      };
    in {
      nixosConfigurations = {
        artemis = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs system; };
          modules = [
            ./system/configuration.nix
            ./system/artemis
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                sharedModules = [ sops-nix.homeManagerModules.sops ];
                useGlobalPkgs = true;
                useUserPackages = true;
                users.c = import ./home;
                extraSpecialArgs = { inherit inputs; };
              };
              nixpkgs = { inherit pkgs; };
            }
          ];
        };
      };
    };
}
