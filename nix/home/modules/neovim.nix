{ pkgs, ... }:
let
  neovim_config = ../../../config_files/nvim;
in
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    withNodeJs = true;
    withPython3 = true;
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = with pkgs; [
      imagemagick
      kitty
    ];
  };

  xdg.configFile = {
    "nvim" = {
      source = "${neovim_config}";
      recursive = true;
    };
  };
}
