{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jdt-language-server
    lua-language-server
    pyright
    gopls
    nil
    typescript-language-server
    bash-language-server
    dprint
    harper
    lemminx
    taplo
    biome
    markdown-oxide
    htmx-lsp
    zk
    marksman
    mdformat
    terraform-ls
    sqls
    sqruff
  ];
}
