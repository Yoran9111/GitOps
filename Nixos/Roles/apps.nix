{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    flux
    git
  ];
}
