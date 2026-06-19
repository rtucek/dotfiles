{ ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    enableMan = true;
    waylandSupport = true;

    # Language providers
    withNodeJs = true;
    withPerl = true;
    withPython3 = true;
    withRuby = true;

    editorconfig = {
      enable = true;
    };

    colorschemes.onedark.enable = true;

    clipboard.register = "unnamedplus";
  };
}
