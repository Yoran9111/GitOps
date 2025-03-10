{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fluxcd
    git
    jdk11
    curl
  ];
}
