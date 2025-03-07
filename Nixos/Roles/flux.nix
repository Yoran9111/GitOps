{ config, lib, pkgs, ... }:

{
  imports = [
    # Import your flux configuration here
    /home/jip/lib/nixos/Nixos/Roles/flux.nix
  ];

  # Now you can use the services.flux option because it's imported
  services.flux = {
    enable = true;
    branch = "main";
    gitRepository = "https://github.com/Yoran9111/GitOps.git";
    secretRef = null;
  };

  # If you want to configure flux with a systemd service:
  systemd.services.flux = {
    description = "Flux GitOps Tool";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.flux}/bin/flux";
    serviceConfig.ExecReload = "${pkgs.flux}/bin/flux";
    serviceConfig.Restart = "always";
  };
}
