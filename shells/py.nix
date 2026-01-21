{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    (python3.withPackages (ps: with ps; [
      debugpy
      jupyter
      ipython
    ]))

    # Package management
    uv

    # LSP & linting
    pyright
    ruff
  ];

  shellHook = ''
    # Use uv for virtual environments
    export UV_PYTHON="${pkgs.python3}/bin/python3"
  '';
}
