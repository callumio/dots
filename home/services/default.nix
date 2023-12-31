{ inputs, config, pkgs, ... }: {
  imports = [ ./mako ];
  services = {
    mpris-proxy.enable = true;
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };
  };
}
