{ ... }:
let
  karabiner_config = ../../../config_files/karabiner;
in
{
  xdg.configFile = {
    "karabiner" = {
      source = "${karabiner_config}";
      recursive = true;
    };
  };
}
