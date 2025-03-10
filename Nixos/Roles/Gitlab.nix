{ config, pkgs, lib, ... }:

{
  # Import the necessary GitLab Runner module
  imports =
    [ 
      # Import the GitLab Runner service module
      <nixos/modules/services/continuous-integration/gitlab-runner.nix>
    ];

  # Enable and configure GitLab Runner service
  services.gitlabRunner = {
    enable = true;
    token = "<your-gitlab-runner-token>";  # Replace with your GitLab Runner registration token
    executor = "shell";  # Shell executor type, you can change to docker if needed
    runners = [
      {
        name = "nixos-runner";
        url = "https://gitlab.com/";  # GitLab instance URL
        token = "<your-gitlab-token>";  # Replace with your GitLab registration token
        description = "GitLab Runner for NixOS";
        tags = [ "nixos" ];  # Runner tags
        run_untagged = true;  # Allow untagged jobs to run
        locked = false;  # Allow to use the runner for any project
      }
    ];
  };

  # Define the gitlab-runner user and group
  users.users.gitlab-runner = {
    isSystemUser = true;
    shell = pkgs.zsh;  # You can set the shell to zsh
    group = "gitlab-runner";  # Define the group for gitlab-runner
  };

  # Create the gitlab-runner group
  users.groups.gitlab-runner = {};

  # Enable zsh globally on the system
  programs.zsh.enable = true;

  # Other settings and options
}
