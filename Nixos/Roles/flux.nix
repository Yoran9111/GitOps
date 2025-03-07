{ config, lib, pkgs, ... }:

# Define Flux options and systemd service inside the config block
{
  options.services.flux = lib.mkOption {
    type = lib.types.attrs;
    description = "Flux configuration options.";
    default = {
      enable = false;
      branch = "main";
      gitRepository = "https://github.com/Yoran9111/GitOps.git";
      secretRef = null;
    };
  };

  # Flux systemd service should go inside the config block
  config = {
    # Enabling Flux and defining its parameters
    services.flux = {
      enable = true;
      branch = "main";
      gitRepository = "https://github.com/Yoran9111/GitOps.git";
      secretRef = null;
    };

    # Configure the systemd service for Flux
    systemd.services.flux = {
      description = "Flux GitOps Tool";
      wantedBy = [ "multi-user.target" ];

      serviceConfig.ExecStart = "${pkgs.flux}/bin/flux";
      serviceConfig.ExecReload = "${pkgs.flux}/bin/flux";
      serviceConfig.Restart = "always";
    };
  };
}
