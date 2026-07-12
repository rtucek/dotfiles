{ ... }:
{
  editorconfig = {
    enable = true;

    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        indent_size = 4;
        tab_width = 8;
        indent_style = "tab";
        insert_final_newline = true;
        max_line_length = 100;
        trim_trailing_whitespace = true;
      };

      "*.{css,scss,sass}" = {
        indent_size = 2;
        indent_style = "space";
      };

      "*.go" = {
        tab_width = 8;
        indent_style = "tab";
      };

      "*.html" = {
        indent_size = 2;
        indent_style = "space";
      };

      "*.md" = {
        trim_trailing_whitespace = false;
      };

      "*.nix" = {
        indent_size = 2;
        indent_style = "space";
      };

      "*.{js,ts,json}" = {
        indent_size = 2;
        indent_style = "space";
      };

      "*.php" = {
        indent_size = 4;
        indent_style = "space";
      };

      "*.py" = {
        indent_size = 4;
        indent_style = "space";
      };

      "*.{yml,yaml}" = {
        indent_size = 2;
        indent_style = "space";
      };
    };
  };
}
