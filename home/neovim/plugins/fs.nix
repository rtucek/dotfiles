{ ... }:
{
  programs.nixvim = {
    keymaps = [
      {
        # Quick edit ~/.vimrc
        action = ":CHADopen<CR>";
        key = "<leader>d";
        mode = [ "n" ];
        options = {
          silent = true;
        };
      }
    ];
    plugins = {
      # see https://github.com/ms-jpq/chadtree/
      chadtree = {
        enable = true;
        settings = {
          ignore.name_exact = [
            ".DS_Store"
            ".directory"
            "thumbs.db"
            ".git"
          ];

          options = {
            show_hidden = true;
            follow = true;
            follow_links = true;
            version_control.enable = true;
          };
        };
      };
    };
  };
}
