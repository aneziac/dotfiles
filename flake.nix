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
      systems = [ "aarch64-darwin" "x86_64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems f;

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
          extraSpecialArgs = { mySystem = "macos"; isDesktop = true;  username = "Nate"; inherit self; };
        };
        "mint" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs "x86_64-linux";
          modules = [ ./home-manager/home.nix ];
          extraSpecialArgs = { mySystem = "mint";  isDesktop = true;  username = "nate"; inherit self; };
        };
        "headless" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs "x86_64-linux";
          modules = [ ./home-manager/home.nix ];
          extraSpecialArgs = { mySystem = "headless"; isDesktop = false; username = "nate"; inherit self; };
        };
      };

      devShells = forAllSystems (system:
        let
          pkgs = mkPkgs system;
          lib  = pkgs.lib;

          # A shell module is either a bare package list or { packages; hook; }.
          importShell = name:
            let m = import (self + "/shells/${name}.nix") { inherit pkgs; };
            in if builtins.isList m
               then { packages = m; hook = ""; }
               else { packages = m.packages or []; hook = m.hook or ""; };

          shells = lib.genAttrs
            [ "dev" "systems" "cpp" "py" "functional" "typescript" "science" "solidity" ]
            importShell;

          mkDevShell = mods: pkgs.mkShell {
            buildInputs = lib.concatMap (m: m.packages) mods;
            shellHook = lib.concatMapStrings (m: m.hook + "\n") mods + ''

              if [[ $- == *i* ]]; then
                exec ${pkgs.zsh}/bin/zsh
              fi
            '';
          };

        in {
          default    = mkDevShell [ shells.dev ];
          systems    = mkDevShell [ shells.systems ];
          cpp        = mkDevShell [ shells.cpp ];
          py         = mkDevShell [ shells.py ];
          functional = mkDevShell [ shells.functional ];
          typescript = mkDevShell [ shells.typescript ];
          science    = mkDevShell [ shells.science ];
          solidity   = mkDevShell [ shells.solidity ];

          # Composed shells
          full = mkDevShell [
            shells.systems shells.py shells.functional
            shells.typescript shells.science shells.solidity
          ];
        }
      );
    };
}
