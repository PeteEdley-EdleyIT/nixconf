{ config, pkgs, lib, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "petere";
  home.homeDirectory = "/home/petere";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    nnn # terminal file manager

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor
    oh-my-zsh

    nixfmt
    python313Packages.python-vlc

    bitwarden
    caffeine-ng

    gnomeExtensions.appindicator
    gnomeExtensions.caffeine

    yt-dlp
    rustdesk-flutter
  ];

  services = {
    nextcloud-client.enable = true;
    caffeine.enable = true;
  };

  programs = {
    eza = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      extraOptions = [ "-l" "--icons" "--git" "-a" ];
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    pay-respects = {
      enable = true;
      enableZshIntegration = true;
    };
    kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
    };
    nix-index = { enable = true; };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      initContent = ''
        neofetch
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "eza" "vscode" "sudo" ];
        theme = "lukerandall";
      };
    };

    git = {
      enable = true;
      userName = "Peter Edley";
      userEmail = "peter@edleyit.com";
      extraConfig = { init.defaultBranch = "main"; };
    };
    vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
    direnv = { enable = true; };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
