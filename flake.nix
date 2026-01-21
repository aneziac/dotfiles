{
  description = "Nate's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, home-manager, neovim-nightly-overlay }:
    let
      mkPkgs = system: import nixpkgs {
        inherit system;
        overlays = [ neovim-nightly-overlay.overlays.default ];
      };
    in
    {
      homeConfigurations = {
        "macos" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs "aarch64-darwin";
          modules = [ ./home-manager/home.nix ];
          extraSpecialArgs = { mySystem = "macos"; };
        };
        "mint" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs "x86_64-linux";
          modules = [ ./home-manager/home.nix ];
          extraSpecialArgs = { mySystem = "mint"; };
        };
        "arch" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs "x86_64-linux";
          modules = [ ./home-manager/home.nix ];
          extraSpecialArgs = { mySystem = "arch"; };
        };
      };

      devShells = {
        x86_64-linux.default = import ./shells/dev.nix {
          pkgs = mkPkgs "x86_64-linux";
        };
        aarch64-darwin.default = import ./shells/dev.nix {
          pkgs = mkPkgs "aarch64-darwin";
        };
      };
    };
}
