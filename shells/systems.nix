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

    # Rust (rust-analyzer is added via rustup in home.nix's activation)
    rustup

    # Go
    go
    gopls
  ];
}
