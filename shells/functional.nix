{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Haskell
    ghc
    cabal-install
    haskell-language-server

    # Coq / Rocq
    rocq-core
    coqPackages.coq-lsp

    # OCaml
    ocaml
    dune_3
    ocamlPackages.ocaml-lsp
    opam

    # Lean (lean4 bundles LSP)
    lean4
  ];
}
