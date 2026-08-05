{ pkgs }:

with pkgs; [
  # C/C++ toolchain
  clang
  clang-tools

  # Building
  gnumake
  ninja
  pkg-config
]
# Debugging
# Note valgrind is broken on aarch64-darwin
++ lib.optional stdenv.isLinux valgrind
