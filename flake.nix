{
  description = "Nate's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager }:
    let
      mkPkgs = system: import nixpkgs {
        inherit system;
        overlays = [
          # Expose the nixpkgs-unstable channel as pkgs.unstable (pure; no NIX_PATH).
          (final: prev: {
            unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
          })
        ];
      };
    in
    {
      homeConfigurations = {
        "macos" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs "aarch64-darwin";
          modules = [ ./home-manager/home.nix ];
          extraSpecialArgs = { mySystem = "macos"; inherit self; };
        };
        "mint" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs "x86_64-linux";
          modules = [ ./home-manager/home.nix ];
          extraSpecialArgs = { mySystem = "mint";  inherit self; };
        };
        "arch" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs "x86_64-linux";
          modules = [ ./home-manager/home.nix ];
          extraSpecialArgs = { mySystem = "arch";  inherit self; };
        };
      };
    };
}
