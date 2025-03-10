{ config, pkgs, ... }:

{
  # GitLab Runner configuration
  services.gitlabRunner = {
    enable = true;
    token = "<your-gitlab-runner-token>";  # Replace with your actual GitLab token
    executor = "shell";
    runners = [
      {
        name = "nixos-runner";
        url = "https://gitlab.com/";
        token = "<your-gitlab-token>";  # Replace with your actual GitLab runner token
        description = "GitLab Runner for NixOS";
        tags = [ "nixos" ];
        run_untagged = true;
        locked = false;
      }
    ];
  };

  # Define the gitlab-runner user
  users.users.gitlab-runner = {
    isSystemUser = true;
    shell = pkgs.zsh;  # Set the shell to zsh
    group = "gitlab-runner";  # Define the group for gitlab-runner
  };

  # Create the gitlab-runner group
  users.groups.gitlab-runner = {};

  # Enable zsh globally on the system
  programs.zsh.enable = true;

  # Other settings and options
}
