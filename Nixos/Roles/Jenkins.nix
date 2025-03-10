{ config, lib, pkgs, ... }: 
{
  services.jenkins = {
    enable = true;                    # Enable Jenkins service
    port = 8079;                      # Specify Jenkins port (default 8080, you can change this)
    user = "jenkins";                 # Jenkins will run under this user
    home = "/var/lib/jenkins";        # Jenkins home directory
  };

  # Ensure Java is available for Jenkins by adding it to system packages
  environment.systemPackages = with pkgs; [
    jdk11  # Java 11 (or you can use jdk17 or jdk21 if needed)
  ];
}
