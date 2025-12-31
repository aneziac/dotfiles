{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { nixpkgs, home-manager, neovim-nightly-overlay, ... }: {
    homeConfigurations = {
      "macos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          mySystem = "macos";
          neovim-nightly = neovim-nightly-overlay.packages.x86_64-linux.default;
        };
      };

      "mint" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          mySystem = "mint";
          neovim-nightly = neovim-nightly-overlay.packages.x86_64-linux.default;
        };
      };

      "arch" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          mySystem = "arch";
          neovim-nightly = neovim-nightly-overlay.packages.x86_64-linux.default;
        };
      };
    };
  };
}
