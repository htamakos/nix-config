{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cargo
    rustc
    clippy
    rust-analyzer
  ];

  home.sessionVariables = {
    CARGO_HOME = "$HOME/.cargo";
  };
}
