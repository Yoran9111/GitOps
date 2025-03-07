{ config, lib, pkgs, ... }:

{
  options = {
    services.flux = lib.mkOption {
      type = lib.types.attrs;
      description = "Flux configuration options.";
      default = {
        enable = false;
        branch = "main";
        gitRepository = "https://github.com/Yoran9111/GitOps.git";
        secretRef = null;
      };
    };
  };

  # Flux systemd service
  systemd.services.flux = {
    description = "Flux GitOps Tool";
    wantedBy = [ "multi-user.target" ];

    serviceConfig.ExecStart = "${pkgs.flux}/bin/flux";
    serviceConfig.ExecReload = "${pkgs.flux}/bin/flux";
    serviceConfig.Restart = "always";
  };

  # Enable Flux service
  config = {
    services.flux = {
      enable = true;
      branch = "main";
      gitRepository = "https://github.com/Yoran9111/GitOps.git";
      secretRef = null;
    };
  };

  # Optionally, you can configure Flux for GitOps here if necessary
}
