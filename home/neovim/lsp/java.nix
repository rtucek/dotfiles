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
  };
}
