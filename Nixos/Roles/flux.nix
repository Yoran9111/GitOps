{ config, pkgs, lib, ... }: 

let
  # Define the GitOps repository URL and the branch to track
  gitRepository = "https://github.com/Yoran9111/GitOps.git"; 
  branch = "main"; # Change this if you are using a different branch
  secretRef = null;  # Use this if you're using SSH keys or private repositories
in

{
  # Enable Flux
  services.flux = {
    enable = true;
    gitRepository = gitRepository;
    branch = branch;
    secretRef = secretRef;
  };

  # Enable Flux to automatically sync configurations
  systemd.services."flux-sync" = {
    wantedBy = [ "multi-user.target" ];
    description = "Flux Sync Service";
    # Define the service that runs flux-sync
    serviceConfig.ExecStart = "${pkgs.fluxctl}/bin/fluxctl sync --k8s-fwd-ns flux";
    restart = "always";
  };

  # Additional Flux configuration, if necessary
  # (e.g., for GitOps repositories using SSH keys)
  # secretRef = "your-secret-reference-here"; # Uncomment if you're using SSH key for authentication

}
