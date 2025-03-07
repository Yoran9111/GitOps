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

  config = {
    services.flux = {
      enable = true;
      branch = "main";
      gitRepository = "https://github.com/Yoran9111/GitOps.git";
      secretRef = null;
    };
  };
}
