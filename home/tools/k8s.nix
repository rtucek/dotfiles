{ pkgs, ... }:
{
  home.packages = [
    # k8s
    pkgs.kubectl

    # Deployment
    pkgs.kubernetes-helm

    # Monitoring
    pkgs.k9s
    pkgs.stern

    # Development
    pkgs.kind
  ];
}
