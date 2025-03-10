{ config, pkgs, ... }: 

{
  environment.systemPackages = with pkgs; [
    wget
    vim
    nginxShibboleth
  ];

  services.nginx = {
    enable = true;
    virtualHosts = {
      "mywebsite.com" = {
        root = "/nix/store/79dljmcihdrv2bcrgp1imms81akxh599-nginx-1.26.3/html";
        
        # Correctly specify listen as a list of ports
        listen = [ { address = "0.0.0.0"; port = 8080; } ];
        
        locations = {
          "/" = {
            proxyPass = "http://192.168.254.134:30080/";
            extraConfig = ''
              index index.html;
              proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            '';
          };
        };
      };
    };
  };

  # Enable OpenSSH for remote access
  services.openssh.enable = true;

  # Configure firewall to allow necessary ports (including 8080)
  networking.firewall.allowedTCPPorts = [ 22 80 443 8080 ];  # Allow traffic on port 8080
}
