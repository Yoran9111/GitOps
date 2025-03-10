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
        # Correctly specify listen configuration as a single string
        listen = "8080";  # Nginx will listen on port 8080
        root = "/nix/store/79dljmcihdrv2bcrgp1imms81akxh599-nginx-1.26.3/html";
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

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 8080 8079 ];
}
