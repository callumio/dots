{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.wpaperd = {
    enable = true;
    settings = {default = {path = "~/Pictures/seaside.jpg";};};
  };
}
