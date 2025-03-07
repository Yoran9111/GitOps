{ config, pkgs, ... }: {
  # Ensure Flux is installed
  environment.systemPackages = with pkgs; [
    flux  # This ensures flux is installed as a package
  ];

  # Configure Flux as a system service
  services.flux = {
    enable = true;
    gitRepository = "https://github.com/Yoran9111/GitOps.git";  # Update to your repository URL
    branch = "main";  # Ensure Flux tracks the correct branch
    secretRef = null;  # If using SSH keys, you can define this
  };
}
