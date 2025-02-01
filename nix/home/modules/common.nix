{ ... }: {
  imports = [
    ../modules/home.nix
    ../modules/packages.nix
    ../modules/neovim.nix
    ../modules/karabiner.nix
    ../modules/iterm2.nix
    ../modules/zsh.nix
    ../modules/python.nix
    ../modules/java.nix
    ../modules/rust.nix
    ../modules/nodejs.nix
    ../modules/lsp.nix
    ../modules/vscode.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
