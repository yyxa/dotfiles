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
    extraGroups = [  "networkmanager" "wheel" "input" "docker"];
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
    # displayManager.autoLogin = {
    #   enable = true;
    #   user = "yyxa";
    # };

    getty = {
      autologinUser = "yyxa";
    };

    # displayManager.sddm = {
      # enable = true;
      # enable = false;
      # wayland.enable = true;
    # };

    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      xkb = {
        layout = "us,ru";
        options = "grp:win_space_toggle";
      };
      dpi = 200;
      libinput.enable = true;
      libinput.touchpad.naturalScrolling = true;
      libinput.mouse.naturalScrolling = false;
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

    # flatpak.enable = true;

    # printing = {
    #   enable = true;
    #   drivers = with pkgs; [
    #     gutenprint
    #     canon-cups-ufr2
    #   ];
    # };
  };

  # system.activationScripts.flatpakRepos.text = ''
  #   ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  # '';

  fonts.packages = with pkgs; [
    material-symbols
    noto-fonts
    #noto-fonts-emoji
    #nerdfonts
    font-awesome
    liberation_ttf
  ];

  # xdg.portal = {
  #   enable = true;
    # wlr.enable = true;
    # extraPortals = [
    #   pkgs.xdg-desktop-portal-gtk
      # pkgs.xdg-desktop-portal-hyprland
  #   ];
  # };

  # qt.enable = true;

  programs = {
    # hyprland = {
    #   enable = true;
    #   xwayland.enable = true;
    # };

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

  virtualisation.docker.enable = true;

  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    vivaldi
    telegram-desktop
    obsidian
    flameshot
    quickshell
    nemo
    git
    bibata-cursors
    neovim
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
    openvpn
    wl-clipboard
    cliphist
    openssl

    gnumake
    cmake
    conan

    feh
    rofi

    # inputs.murglar-nix.packages.x86_64-linux.default
    # discord
    #hiddify-app
    #libappindicator-gtk3
    #gnomeExtensions.topicons-plus
    # bashInteractive
    # xorg.xhost
    #nekoray
    # libnotify    
    # zoxide
    # eza
    # fzf
    # git-lfs
    # rustup
    # rustc
    # vesktop
    #postman
    # zoom-us
    # stellarium
    # rustdesk
    # anydesk
    # jq
    # libinput-gestures
    # swaylock-effects
    # hypridle
    # hyprland
    # hyprpaper
    # xdg-desktop-portal-gtk
    # xdg-desktop-portal-hyprland
    # slurp
    # grim
    # xwayland
    # waybar
    # pywal
    # hyprpicker
    # swaynotificationcenter
    # mako
    # playerctl
    # iw
    # wpa_supplicant
    # bat
    # pipx
    # doxygen
    #oh-my-zsh
    # yazi
    # obs-studio
    #thefuck
    # unzip
    #python310
    #python310Packages.ipykernel
    #python310Packages.pip
    # python310Packages.notebook
    #python310Packages.virtualenv
    # python310Packages.pandas
    # python310Packages.numpy
    # python310Packages.torch
    # python310Packages.torchvision
    # jupyter
    # awscli2
    # gcc
    # stdenv.cc.cc.lib
    # libGL
    # mesa
    #ngrok
    #python310Packages.conda
    # pkg-config
    # dive
    # wine
    # winetricks
    # virtualbox
    # code-cursor
    #nodejs_18
    # gtk2
    # gdb
    # fftw
    # opencv
    # libpulseaudio
    # xorg.libX11
    # xorg.libXrandr
    # xorg.libXinerama
    # xorg.libXcursor
    # xorg.libXi
    #mesa.dev
    # ctop
    # gdb
    #modrinth-app
    # jdk21
    # imagemagick
    # home-manager
    # eww
    # qt6.qtquick3d
    #(flameshot.overrideAttrs (old: {
    #  cmakeFlags = old.cmakeFlags ++ ["-DUSE_WAYLAND_GRIM=ON"];
    #}))

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
      '';

      buildInputs = with pkgs; [ libx11 libxft libxinerama ];
      makeFlags = [ "PREFIX=$(out)" ];
    })

  ];

  system.stateVersion = "25.11";
}

