{ config, lib, pkgs, ... }:

{
  # Define the Flux GitOps service in NixOS configuration
  services.flux = {
    enable = true;  # Enable the Flux service
    branch = "main";  # Specify the Flux branch you want to use
    gitRepository = "https://github.com/Yoran9111/GitOps.git";  # The Git repository for Flux
    secretRef = null;  # If you have any secret configuration, set it here
  };

  # Enable systemd service for flux (this is automatically handled)
  systemd.services.flux = {
    description = "Flux GitOps Tool";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.flux}/bin/flux";
    serviceConfig.ExecReload = "${pkgs.flux}/bin/flux";
    serviceConfig.Restart = "always";
  };
}
