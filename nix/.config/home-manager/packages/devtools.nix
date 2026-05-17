{ pkgs, lib, ... }:

{
  home.packages =
    with pkgs;
    [
      # LSPs
      nixd
      pyright
      rust-analyzer
      markdown-oxide

      # Formatters / Linters
      nixfmt
      stylua
      ruff
      markdownlint-cli2
      tree-sitter

      # Languages / Toolchains
      nodejs
      yarn
      cargo
      rustc
      rustfmt
      uv
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      # Linux-only (Darwin uses kqueue natively for LSP file watching)
      inotify-tools
    ];
}
