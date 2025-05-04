# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,ru";
    # variant = "grp:win_space_toggle";
    options = "grp:win_space_toggle";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.drama = {
    isNormalUser = true;
    description = "drama";
    extraGroups = [ "networkmanager" "wheel" "input" "docker" "vboxusers"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
 
  nixpkgs.config.permittedInsecurePackages = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # вроде не помогло лоурез хромиум приложух убрать
  #environment.sessionVariables.NIXOS_OZONE_WL = "1";
 
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  services.dbus.enable = true;
  services.greetd.enable = true;
  services.greetd.settings.default_session = {
    command = "Hyprland";
    user = "drama";
  };
  services.udisks2.enable = true;
  #services.resolved.enable = true;
  services.flatpak.enable = true;
  system.activationScripts.flatpakRepos.text = ''
    ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  '';

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  programs.zsh = {
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
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  fonts.packages = with pkgs; [
    nerdfonts
    font-awesome
    liberation_ttf
  ];

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableHardening = false;
  users.extraGroups.vboxusers.members = [ "drama" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;

  boot.kernelModules = [ "vboxdrv" "vboxnetflt" "vboxnetadp" "vboxpci" ];

  services.udev.extraRules = ''
    KERNEL=="vboxdrv", GROUP="vboxusers", MODE="0660"
    KERNEL=="vboxnetctl", GROUP="vboxusers", MODE="0660"
    KERNEL=="vboxnetadp", GROUP="vboxusers", MODE="0660"
    KERNEL=="vboxnetflt", GROUP="vboxusers", MODE="0660"
  '';

  
  environment.variables = {
    SHELL = "${pkgs.bashInteractive}/bin/bash";

    OPENSSL_DIR = "${pkgs.openssl.dev}";
    OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
    OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
    PKG_CONFIG_PATH = lib.concatStringsSep ":" [
      "${pkgs.openssl.dev}/lib/pkgconfig"
      "${pkgs.gtk2.dev}/lib/pkgconfig"
      "${pkgs.gtk2.out}/lib/pkgconfig"
    ];
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    inputs.yandex-browser.packages.${pkgs.system}.yandex-browser-stable
    hiddify-app
    #libappindicator-gtk3
    #gnomeExtensions.topicons-plus
    bashInteractive
    xorg.xhost
    nekoray
    libnotify
    appimage-run
    nemo
    vlc
    zoxide
    eza
    fzf
    git-lfs
    rustup
    rustc
    vesktop
    postman
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
    telegram-desktop
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
    git
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
    obsidian
    obs-studio
    fastfetch
    thefuck
    flameshot
    pipewire
    udiskie
    udisks2
    unzip
    python310
    python310Packages.ipykernel
    python310Packages.pip
    # python310Packages.notebook
    python310Packages.virtualenv

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
    ngrok
    python310Packages.conda
    openssl
    pkg-config
    dive
    wine
    winetricks
    virtualbox
    code-cursor
    lmms
    nodejs_18
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
    mesa.dev

    ctop
    gdb
    modrinth-app
    jdk21
    imagemagick

    # home-manager
    stow
    eww

    (flameshot.overrideAttrs (old: {
      cmakeFlags = old.cmakeFlags ++ ["-DUSE_WAYLAND_GRIM=ON"];
    }))
    
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}

