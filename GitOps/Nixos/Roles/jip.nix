{ config, pkgs, ... }: 

{
  users.extraUsers.jip = {
    description = "Jip";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    uid = 1000;
  };
}
