{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    gcc
    gnumake
    cmake
    ninja
    gdb
    clang-tools     # clangd для LSP
    pkg-config
    openssl.dev
    boost           # если часто используешь
    fftw
    opencv          # уже есть в твоей системе, но удобно иметь в shell
  ];
}