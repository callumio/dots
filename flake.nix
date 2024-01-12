{
  description = "99 with a Flake please :D";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, hyprland, firefox-addons
    , neovim-nightly-overlay, ... }@inputs:
    let
      system = "x86_64-linux";
      stateVersion = "23.11";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [ neovim-nightly-overlay.overlay ];
      };
      inherit (nixpkgs) lib;
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
