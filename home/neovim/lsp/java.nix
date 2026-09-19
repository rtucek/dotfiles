{ pkgs, ... }:
{
  programs.nixvim = {
    lsp.servers = {
      # see https://github.com/eclipse/eclipse.jdt.ls
      jdtls = {
        enable = true;
        config = {
          cmd = [
            "jdtls"
            "--jvm-arg=-javaagent:${pkgs.lombok}/share/java/lombok.jar"
          ];
        };
      };
    };

    plugins.none-ls = {
      sources.formatting = {
        google_java_format = {
          enable = true;
          package = pkgs.google-java-format;
          settings = {
            filetypes = [ "java" ];
            extra_args = [ "--aosp" ];
          };
        };
      };
    };
  };
}
