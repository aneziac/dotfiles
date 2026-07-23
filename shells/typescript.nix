{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs
    typescript
    typescript-language-server
    prettier
  ];
}
