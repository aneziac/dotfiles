{ pkgs }:

{
  packages = with pkgs; [
    (python3.withPackages (ps: with ps; [
      debugpy
      jupyter
      ipython
      pynvim
      jupyter-client
    ]))

    # Package management
    uv

    # LSP & linting
    pyright
    ruff
  ];

  hook = ''export UV_PYTHON="${pkgs.python3}/bin/python3"'';
}
