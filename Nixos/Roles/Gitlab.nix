{ config, pkgs, ... }: 

{
  # Enable and configure GitLab Runner service
  services.gitlabRunner = {
    enable = true;                    # Enable GitLab Runner service
    token = "<your-gitlab-runner-token>";  # Replace with your GitLab Runner registration token
    executor = "shell";               # Set the executor type (shell is simplest)
    runners = [
      {
        name = "nixos-runner";         # A meaningful name for your runner
        url = "https://gitlab.com/";   # GitLab instance URL
        token = "<your-gitlab-token>";  # Replace with your GitLab registration token
        description = "GitLab Runner for NixOS";  # Description for your runner
        tags = [ "nixos" ];            # Tags to help identify the runner
        run_untagged = true;           # Allow the runner to run without tags
        locked = false;                # The runner is not locked to specific projects
      }
    ];
  };
}
