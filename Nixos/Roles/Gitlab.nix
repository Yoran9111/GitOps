{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    gitlab-runner
    # Add other packages here
  ];

  # Define GitLab Runner service as a systemd service
  systemd.services.gitlab-runner = {
    description = "GitLab Runner";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig.ExecStart = "${pkgs.gitlab-runner}/bin/gitlab-runner run";
    serviceConfig.ExecReload = "${pkgs.gitlab-runner}/bin/gitlab-runner restart";
    serviceConfig.ExecStop = "${pkgs.gitlab-runner}/bin/gitlab-runner stop";
  };

  # Ensure GitLab Runner runs as a specific user (optional)
  users.users.gitlab-runner = {
    isSystemUser = true;
    shell = pkgs.bashInteractive;
  };
}
