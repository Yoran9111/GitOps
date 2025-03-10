{ config, pkgs, ... }: 

{
  # Add system packages to install on NixOS
  environment.systemPackages = with pkgs; [
    fluxcd           # Flux CD (for GitOps)
    git              # Git for version control
    jdk11            # Java 11 (or you can use jdk17 or jdk21 if needed)
    curl             # Curl for making network requests
    gitlab-runner    # GitLab Runner for CI/CD pipelines
    openssh-client   # SSH client (for secure communication)
    vim              # A text editor (if you prefer Vim)
    wget             # A tool for downloading files from the web
  ];
}
