{ config, lib, pkgs, ... }:

{
  services.flux = {
    enable = true;
    branch = "main";
    gitRepository = "https://github.com/Yoran9111/GitOps.git";
    secretRef = null;
  };

  systemd.services.flux = {
    description = "Flux GitOps Tool";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.flux}/bin/flux";
    serviceConfig.ExecReload = "${pkgs.flux}/bin/flux";
    serviceConfig.Restart = "always";
  };
}
