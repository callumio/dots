{
  description = "99 with a Flake please :D";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };
    nixvim = {
      url = "github:callumio/nixvim";
      #inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
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
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    firefox-addons,
    nixvim,
    stylix,
    ...
  } @ inputs: let
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
      config = {allowUnfree = true;};
      overlays = [unstable-packages];
    };
  in {
    nixosConfigurations = {
      artemis = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs system;};
        modules = [
          ./system/configuration.nix
          ./system/artemis
          stylix.nixosModules.stylix

          {
            nix.settings = {
              substituters = [
                "https://cache.nixos.org"
                "https://nix-community.cachix.org"
                "https://callumio-public.cachix.org"
              ];

              trusted-public-keys = [
                "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                "callumio-public.cachix.org-1:VucOSl7vh44GdqcILwMIeHlI0ufuAnHAl8cO1U/7yhg="
              ];
            };
          }

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              sharedModules = [
                {
                  stylix.targets = {
                    fish.enable = false;
                  };
                }
              ];
              useGlobalPkgs = true;
              useUserPackages = true;
              users.c = import ./home;
              extraSpecialArgs = {inherit inputs;};
            };
            nixpkgs = {inherit pkgs;};
          }
        ];
      };
    };
  };
}
