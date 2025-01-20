{ ... }:
let
  iterm2_config = ../../../config_files/iterm2;
in
{
  xdg.configFile = {
    "iterm2" = {
      source = "${iterm2_config}";
      recursive = true;
    };
  };
}
