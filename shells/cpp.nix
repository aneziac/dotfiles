{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # C/C++ toolchain
    # clang
    # clang-tools

    # Building
    # gnumake
    # ninja
    # pkg-config

    # Debugging
    gef
    lldb
    # valgrind
  ];
}
