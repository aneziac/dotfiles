{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }: {
    homeConfigurations = {
      "macos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./home.nix ];
      };
 
      # "mint" = home-manager.lib.homeManagerConfiguration {
      #   pkgs = nixpkgs.legacyPackages.x86_64-linux;
      #   modules = [ ./home.nix ];
      # };
      # 
      # "arch" = home-manager.lib.homeManagerConfiguration {
      #   pkgs = nixpkgs.legacyPackages.x86_64-linux;
      #   modules = [ ./home.nix ];
      # };
    };
  };
}
