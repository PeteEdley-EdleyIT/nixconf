{ pkgs, ... }: {
  users.users.petere = {
    isNormalUser = true;
    description = "Peter Edley";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
  home-manager.users.petere = import ./petere/home.nix;
}
