{ config, lib, pkgs, ... }:

{
  # Import Flux configuration file from the custom path
  imports = [
    /home/jip/lib/nixos/Nixos/Roles/flux.nix  # Ensure this path is correct
  ];

  # Enable Flux service
  services.flux = {
    enable = true;
    branch = "main";  # Specify the branch (default is "main")
    gitRepository = "https://github.com/Yoran9111/GitOps.git";  # Repository URL
    secretRef = null;  # Configure secret reference if needed
  };

  # Systemd service configuration for Flux
  systemd.services.flux = {
    description = "Flux GitOps Tool";
    wantedBy = [ "multi-user.target" ];

    serviceConfig.ExecStart = "${pkgs.flux}/bin/flux";
    serviceConfig.ExecReload = "${pkgs.flux}/bin/flux";
    serviceConfig.Restart = "always";
  };
}
