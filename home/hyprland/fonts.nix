{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Icon fonts
    material-symbols

    # Sans(Serif) fonts
    libertinus
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    roboto
    (google-fonts.override { fonts = [ "Inter" ]; })

    # Monospace fonts
    jetbrains-mono

    # Nerdfonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only

    # Icon fonts
    font-awesome
  ];
}
