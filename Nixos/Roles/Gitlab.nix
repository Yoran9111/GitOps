{ config, pkgs, ... }:

{
  # Create the gitlab-runner group
  users.groups.gitlab-runner = {};

  # Create the gitlab-runner user
  users.users.gitlab-runner = {
    isSystemUser = true;    # This ensures that no home directory is created for this user
    shell = pkgs.bashInteractive;  # Assign a shell to the user
    group = "gitlab-runner";  # Link the user to the group created above
  };

  # Optionally, you can configure GitLab Runner as a service
  systemd.services.gitlab-runner = {
    description = "GitLab Runner";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig.ExecStart = "${pkgs.gitlab-runner}/bin/gitlab-runner run";
    serviceConfig.ExecReload = "${pkgs.gitlab-runner}/bin/gitlab-runner restart";
    serviceConfig.ExecStop = "${pkgs.gitlab-runner}/bin/gitlab-runner stop";
  };

  # Include any other configuration specific to your setup
}
