{ pkgs }:

{
  packages = with pkgs; [
    # Debugging
    gef
    lldb

    # Rust
    rustup

    # Go
    go
    gopls

    # Zig
    zig
  ];

  hook = ''
    if ! ${pkgs.rustup}/bin/rustup toolchain list 2>/dev/null | grep -q "(default)"; then
      ${pkgs.rustup}/bin/rustup default stable
      ${pkgs.rustup}/bin/rustup component add rust-analyzer
    fi
  '';
}
