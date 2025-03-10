{ config, lib, pkgs, ... }: 

{ 
services.jenkins = {
  enable = true;
  port = 8080;  # Change this if needed
  user = "jenkins";  # Runs as jenkins user
  home = "/var/lib/jenkins";  # Jenkins home directory
  javaPackage = pkgs.jdk11;  # Java version required by Jenkins
  };
}

