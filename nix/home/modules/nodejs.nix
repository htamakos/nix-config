{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodePackages.npm
    nodejs
    deno
    yarn
  ];
}
