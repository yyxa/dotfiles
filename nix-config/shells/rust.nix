{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    rustup          # включает cargo, rustc, rustfmt, clippy и т.д.
    rust-analyzer   # для LSP в редакторах (VS Code, neovim и т.п.)
    pkg-config
    openssl.dev
    gcc             # нужен для линковки нативных зависимостей
  ];
}