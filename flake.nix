{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    dotfiles = {
      url = "github:eagle23111/dotfiles";
      flake = false;
    };

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland?submodules=1";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    nvchad4nix.url = "github:nix-community/nix4nvchad";
    nvchad4nix.inputs.nixpkgs.follows = "nixpkgs";

    ucodenix.url = "github:e-tho/ucodenix";

    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      hyprland,
      nvchad4nix,
      catppuccin,
      ...
    }:
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./hardware-configuration.nix
            ./nixos-modules/nvidia.nix
            ./nixos-modules/gaming.nix
            ./nixos-modules/qemu.nix

            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mortal.imports = [
                ./home.nix
                catppuccin.homeModules.catppuccin
              ];
              home-manager.users.isolateduser.imports = [
                ./home_isolated.nix
                catppuccin.homeModules.catppuccin
              ];
              home-manager.backupFileExtension = "hm2-backup";
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}
