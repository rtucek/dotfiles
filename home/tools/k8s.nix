{ pkgs, ... }:
{
  home.packages = [
    # k8s
    pkgs.kubectl

    # Deployment
    pkgs.helm

    # Monitoring
    pkgs.k9s
    pkgs.stern
  ];
}
