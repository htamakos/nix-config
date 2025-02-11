{pkgs,...}: {
  home.packages = with pkgs; [
    # Modern Unix Commands
    silver-searcher
    fd
    fzf
    jq
    mcfly
    ripgrep
    choose
    sd
    cheat
    tldr
    bottom
    glances
    hyperfine
    gping
    procs
    dog
    duf
    dust
    broot
    delta
    lsd
    bat
    wget

    # Containers
    kubectl
    kubernetes-helm
    kustomize
    docker
    kind

    # Languages
    uv
    go

    # Dev
    peco
    jq
    gh
    ghq

    # Shell
    zsh-completions

    # Nix
    nh

    # IaC Tool
    terraform

    # GUI
    slack

    # Network
    dig

    # Utilities
    tree
    coreutils

    # Cloud
    google-cloud-sdk
    awscli2

    imagemagick
    kitty

    # DB
    sqlcl
  ];
}
