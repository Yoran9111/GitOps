{ config, pkgs, ... }:

{
  # Enable Flux in the system
  services.flux = {
    enable = true;
    gitRepository = "https://github.com/Yoran9111/GitOps.git";  # This is your repository URL
    branch = "main";  # Ensure Flux tracks the main branch or change it based on your needs
    secretRef = null;  # Use this field if you're using SSH keys for private repositories
  };

  # Enable Flux to apply NixOS configurations automatically
  systemd.services."flux-sync" = {
    wantedBy = [ "multi-user.target" ];
  };
}
