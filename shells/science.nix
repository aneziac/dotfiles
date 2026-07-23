{ pkgs }:

# `unstable` is provided by the overlay in flake.nix (pkgs.unstable).
pkgs.mkShell {
  buildInputs = with pkgs; [
    sioyek
    unstable.typst
    unstable.tinymist
    quarto
  ];
}
