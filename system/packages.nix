{ inputs, config, pkgs, ... }: {
  programs = {
    fish.enable = true;
    nix-ld.enable = true;
    virt-manager.enable = true;
  };
  programs.java.enable = true;
  programs.java.package = pkgs.jdk21;

  services = { mullvad-vpn.enable = true; };

  environment.systemPackages = with pkgs; [
    vim
    wget
    fzf
    nil
    killall
    gcc
    pkg-config
  ];

  fonts.packages = with pkgs; [ nerdfonts meslo-lgs-nf ];

}
