{ ... }: {
  home.file = {
    ".zshrc" = {
      source = ../../shell/zsh/zshrc;
    };
  };

  programs.zsh.initExtra = ''
  compdef kubecolor=kubectl
  '';

  xdg.configFile = {
    "starship" = {
      source = ../../shell/starship;
      recursive = true;
    };
  };
}
