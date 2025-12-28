{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
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
    extraGroups = [  "networkmanager" "wheel" "input" "docker" "vboxusers" "dialout" ];
    packages = with pkgs; [];
    initialPassword = "1850";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = true;
  };
  
  hardware.bluetooth.enable = true;

  services = {
    displayManager.autoLogin = {
      enable = true;
      user = "yyxa";
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    xserver.xkb = {
      layout = "us,ru";
      options = "grp:win_space_toggle";
    };

    blueman.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    dbus.enable = true;

    #greetd = {
    #  enable = true;
    #  settings.default_session = {
    #    command = "Hyprland";
    #    user = "yyxa";
    #  };
    #};

    udisks2.enable = true;

    flatpak.enable = true;

    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        canon-cups-ufr2
      ];
    };
  };

  system.activationScripts.flatpakRepos.text = ''
    ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  '';

  fonts.packages = with pkgs; [
    material-symbols
    noto-fonts
    #noto-fonts-emoji
    #nerdfonts
    font-awesome
    liberation_ttf
  ];

  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  qt.enable = true;

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    firefox.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      #autosuggestions.enable = true;
      #syntaxHighlighting.enable = true;
      #ohMyZsh = {
      #  enable = true;
      #  plugins = [
      #    "git"
      #    "thefuck"
      #  ];
      #};
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    inputs.murglar-nix.packages.x86_64-linux.default
    inputs.yandex-browser.packages.x86_64-linux.yandex-browser-stable
    yandex-music
    telegram-desktop
    discord
    obsidian
    flameshot
    

    quickshell

    #hiddify-app
    #libappindicator-gtk3
    #gnomeExtensions.topicons-plus
    bashInteractive
    xorg.xhost
    #nekoray
    libnotify
    nemo
    zoxide
    eza
    fzf
    git
    git-lfs
    rustup
    rustc
    vesktop
    #postman
    zoom-us
    stellarium
    rustdesk
    anydesk
    bibata-cursors
    jq
    libinput-gestures
    neovim
    wget
    curl
    swaylock-effects
    hypridle
    hyprland
    hyprpaper
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    slurp
    grim
    xwayland
    firefox
    waybar
    pywal
    hyprpicker
    blueman
    bluez
    swaynotificationcenter
    wofi
    kitty
    tmux
    mako
    brightnessctl
    playerctl
    networkmanager
    networkmanagerapplet
    iw
    wpa_supplicant
    bat
    pipx
    doxygen
    gnumake
    zsh
    cmake
    conan
    #oh-my-zsh
    starship
    btop
    yazi
    docker
    docker-compose
    vscode
    obs-studio
    fastfetch
    #thefuck
    pipewire
    udiskie
    udisks2
    unzip
    #python310
    #python310Packages.ipykernel
    #python310Packages.pip
    # python310Packages.notebook
    #python310Packages.virtualenv

    # python310Packages.pandas
    # python310Packages.numpy
    # python310Packages.torch
    # python310Packages.torchvision
    jupyter
    awscli2
    gcc
    stdenv.cc.cc.lib
    libGL
    mesa
    #ngrok
    #python310Packages.conda
    openssl
    pkg-config
    dive
    wine
    winetricks
    virtualbox
    # code-cursor
    #nodejs_18
    ffmpeg
    gtk2
    gdb

    fftw
    opencv
    libpulseaudio
    xorg.libX11
    xorg.libXrandr
    xorg.libXinerama
    xorg.libXcursor
    xorg.libXi
    #mesa.dev

    ctop
    gdb
    #modrinth-app
    jdk21
    imagemagick

    # home-manager
    stow
    eww
    openvpn

    wl-clipboard
    cliphist

    qt6.qtquick3d
    
    
    #(flameshot.overrideAttrs (old: {
    #  cmakeFlags = old.cmakeFlags ++ ["-DUSE_WAYLAND_GRIM=ON"];
    #}))
  ];

  system.stateVersion = "25.11";
}

