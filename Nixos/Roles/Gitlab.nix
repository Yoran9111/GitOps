{ config, pkgs, ... }:

{
  # Create the group for gitlab-runner
  users.groups.gitlab-runner = {};

  # Create the gitlab-runner user with a shell
  users.users.gitlab-runner = {
    isSystemUser = true; # Do not create a home directory
    shell = pkgs.bashInteractive; # Assign a shell to the user
    group = "gitlab-runner"; # Link the user to the group
  };

  # Optional: If you have GitLab Runner installed, configure the service
  systemd.services.gitlab-runner = {
    description = "GitLab Runner";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig.ExecStart = "${pkgs.gitlab-runner}/bin/gitlab-runner run";
    serviceConfig.ExecReload = "${pkgs.gitlab-runner}/bin/gitlab-runner restart";
    serviceConfig.ExecStop = "${pkgs.gitlab-runner}/bin/gitlab-runner stop";
  };

  # Add other configurations as needed
}
