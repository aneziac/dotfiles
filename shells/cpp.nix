{ pkgs }:

let
  devShell = import ./dev.nix { inherit pkgs; };
in
pkgs.mkShell {
  inputsFrom = [ devShell ];

  buildInputs = with pkgs; [
    # C/C++ toolchain
    clang
    clang-tools

    # Building
    cmake
    gnumake
    ninja
    pkg-config

    # Debugging
    gef
    lldb
    valgrind
  ];
}
