{ ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    enableMan = true;
    enablePrintInit = true;
    waylandSupport = true;

    withNodeJs = true;
    withPerl = true;
    withPython3 = true;
    withRuby = true;

    editorconfig = {
      enable = true;
    };

    colorschemes.gruvbox.enable = true;
  };
}
