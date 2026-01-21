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

      packages.x86_64-linux.devContainer =
        let
          pkgs = mkPkgs "x86_64-linux";
          devShell = import ./shells/dev.nix { inherit pkgs; };
        in
        pkgs.dockerTools.buildLayeredImage {
          name = "dev-env";
          tag = "latest";

          contents = [
            pkgs.dockerTools.usrBinEnv
            pkgs.dockerTools.binSh
            pkgs.dockerTools.caCertificates
            pkgs.dockerTools.fakeNss
            pkgs.coreutils
          ] ++ devShell.buildInputs;

          config = {
            Cmd = [ "${pkgs.zsh}/bin/zsh" ];
            Env = [
              "PATH=/bin"
              "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
              "FPATH=/share/zsh/site-functions:/share/zsh/5.9/functions"
            ];
          };
        };
    };
}
