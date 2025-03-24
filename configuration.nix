# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

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
    variant = "grp:alt_shift_toggle";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.drama = {
    isNormalUser = true;
    description = "drama";
    extraGroups = [ "networkmanager" "wheel" "input"];
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    inputs.yandex-browser.packages.${pkgs.system}.yandex-browser-stable
    hiddify-app
    #libappindicator-gtk3
    #gnomeExtensions.topicons-plus
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
    python312
    python312Packages.ipykernel
    python312Packages.pip
    python312Packages.notebook
    python312Packages.pandas
    python312Packages.numpy
    jupyter

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

