{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fluxcd
    git
  ];
}
