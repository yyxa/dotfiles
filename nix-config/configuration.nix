{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    efi = {
      efiSysMountPoint = "/boot";
      canTouchEfiVariables = true;
    };
  };

  swapDevices = [ 
    { device = "/dev/nvme0n1p7"; } 
  ];

  networking = {
    hostName = "yyxa";
    networkmanager.enable = true;
  };

  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };
  
  users.users.yyxa = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "input" "docker" ];
    packages = with pkgs; [];
    initialPassword = "1850";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = true;
  };
  
  hardware.bluetooth.enable = true;

  services.resolved.enable = true;
  networking.resolvconf.enable = false;

  services = {
    getty = {
      autologinUser = "yyxa";
    };

    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      xkb = {
        layout = "us,ru";
        options = "grp:win_space_toggle";
      };
      dpi = 200;  # 14" 2880x1800
    };
    libinput.enable = true;
    libinput.touchpad.naturalScrolling = true;
    libinput.mouse.naturalScrolling = false;

    blueman.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    dbus.enable = true;
    udisks2.enable = true;
  };

  fonts.packages = with pkgs; [
    material-symbols
    noto-fonts
    font-awesome
    liberation_ttf
  ];

  programs = {
    firefox.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
    };

    openvpn3.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  virtualisation.docker.enable = true;

  environment.variables = {
    XCURSOR_SIZE = "48";
    XCURSOR_THEME = "Bibata-Modern-Classic";
  };

  environment.systemPackages = with pkgs; [
    vivaldi
    telegram-desktop
    obsidian
    flameshot
    nemo
    bibata-cursors
    wget
    curl
    firefox
    blueman
    bluez
    kitty
    tmux
    brightnessctl
    networkmanager
    networkmanagerapplet
    zsh
    starship
    btop
    docker
    docker-compose
    vscode
    fastfetch
    pipewire
    udiskie
    udisks2
    ffmpeg
    stow
    wl-clipboard
    cliphist
    openssl

    gnumake
    cmake
    conan

    feh
    rofi

    v2raya
    openvpn3

    neovim
    ripgrep
    fd
    git
    gcc                 # для treesitter (очень важен)

    # # === LSP-сервера ===
    # pyright             # Python
    # rust-analyzer       # Rust
    # gopls               # Golang
    # nil                 # Nix (полезно)
    # lua-language-server # Lua

    # # Web / JS / Frontend
    # typescript-language-server
    # vscode-langservers-extracted  # HTML, CSS, JSON

    # # Другие
    # yaml-language-server
    # dockerfile-language-server
    # taplo               # TOML
    # shellcheck          # Shell (линтер)
    # bash-language-server # Shell LSP

    # # Форматтеры / доп. инструменты
    # stylua              # Lua
    # nixfmt    # Nix
    # black               # Python formatter
    # ruff                # Python fast linter
    # go-tools            # Golang extras

    inputs.murglar-nix.packages.x86_64-linux.default

    xinit

    (stdenv.mkDerivation rec {
      name = "vxwm";
      src = pkgs.fetchgit {
        url = "https://codeberg.org/wh1tepearl/vxwm.git";
        rev = "refs/heads/main";
        sha256 = "sha256-NPLOPeJceAqdRXOLb8mOLO9IbSHjD/ecMniIttxWBIg=";
      };
      prePatch = ''
        cp ${/home/yyxa/dotfiles/vxwm/config.def.h} config.def.h
        cp ${/home/yyxa/dotfiles/vxwm/modules.def.h} modules.def.h
      '';
      buildInputs = with pkgs; [ libx11 libxft libxinerama ];
      makeFlags = [ "PREFIX=$(out)" ];
    })
  ];

  system.stateVersion = "25.11";
}