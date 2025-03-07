{ config, lib, pkgs, ... }:

{
  # Import Flux configuration
  imports = [
    /home/jip/lib/nixos/Nixos/Roles/flux.nix
  ];

  # Minimal Flux configuration
  services.flux = {
    enable = true;
    branch = "main";  # Specify the branch (default is "main")
    gitRepository = "https://github.com/Yoran9111/GitOps.git";  # Your GitOps repo
    secretRef = null;  # Optional secret reference
  };

  # Simplified systemd service for Flux
  systemd.services.flux = {
    description = "Flux GitOps Tool";
    wantedBy = [ "multi-user.target" ];

    serviceConfig.ExecStart = "${pkgs.flux}/bin/flux";
    serviceConfig.ExecReload = "${pkgs.flux}/bin/flux";
    serviceConfig.Restart = "always";
  };
}
