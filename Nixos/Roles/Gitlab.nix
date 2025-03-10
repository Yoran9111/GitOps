{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gitlab-runner  # Install GitLab Runner
  ];

  # GitLab Runner configuration
  systemd.services.gitlab-runner = {
    description = "GitLab Runner";
    after = [ "network.target" ];
    serviceConfig.ExecStart = "${pkgs.gitlab-runner}/bin/gitlab-runner run";
    serviceConfig.User = "gitlab-runner";
    serviceConfig.Group = "gitlab-runner";
    serviceConfig.Restart = "always";
  };

  # Create the gitlab-runner user and group
  users.users.gitlab-runner = {
    isSystemUser = true;
    shell = pkgs.zsh;  # Set to the shell you want for the user
  };
}
