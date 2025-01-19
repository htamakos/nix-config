{ pkgs
, outputs
, userConfig
, ...
}: {
  programs.zsh.enable = true;

  system.stateVersion = 5;
}
