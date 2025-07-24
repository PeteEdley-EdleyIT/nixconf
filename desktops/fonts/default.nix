{ config, pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
    aggregated = pkgs.buildEnv {
      name = "system-fonts-and-icons";
      paths = with pkgs; [
        libsForQt5.breeze-qt5
        noto-fonts
        noto-fonts-emoji
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        corefonts
        fira-code
        fira-code-symbols
        nerd-fonts.fira-code
        font-manager
        font-awesome_5
        noto-fonts
      ];
      pathsToLink = [ "/share/fonts" "/share/icons" ];
    };
  in {
    "/usr/share/icons" = mkRoSymBind "${aggregated}/share/icons";
    "/usr/share/fonts" = mkRoSymBind "${aggregated}/share/fonts";
  };
}
