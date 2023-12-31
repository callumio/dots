{ config, inputs, pkgs, ... }: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
    '';
    shellAliases = { v = "nvim"; };

    plugins = with pkgs.fishPlugins; [
      {
        name = "z";
        inherit (z) src;
      }
      {
        name = "hydro";
        inherit (hydro) src;
      }
      {
        name = "sponge";
        inherit (sponge) src;
      }
      {
        name = "grc";
        inherit (grc) src;
      }
      {
        name = "done";
        inherit (done) src;
      }
      {
        name = "fzf-fish";
        inherit (fzf-fish) src;
      }
      {
        name = "forgit";
        inherit (forgit) src;
      }
    ];
  };
}
