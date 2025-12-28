{ pkgs }:

let
  myPython = pkgs.python312.withPackages (ps: with ps; [
    pip
    virtualenv
    jupyter
    numpy
    pandas
    matplotlib
    requests
    ipykernel
    torch
    torchvision
    # добавь сюда любые часто используемые пакеты
  ]);
in
pkgs.mkShell {
  buildInputs = [
    myPython
    pkgs.poetry     # если используешь poetry
    pkgs.nodejs     # иногда нужен для jupyter extensions
  ];
}