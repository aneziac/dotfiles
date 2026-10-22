{ pkgs }:

# `unstable` is provided by the overlay in flake.nix (pkgs.unstable).
with pkgs; [
  unstable.typst
  unstable.tinymist
  quarto
  julia

  # Docs & writing
  hugo
  go
]
