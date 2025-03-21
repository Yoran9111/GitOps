# VirtualBox Configuration with Btrfs Disk Setup
{ config, lib, pkgs, ... }: 

{
  imports = [
    ../Roles/Nginx.nix  # Include Nginx Config
    ../Roles/Network.nix  # Include Network Config
    ../Roles/jip.nix  # Include User Config
    ../Roles/apps.nix # Includes apps
    ../Roles/Gitlab.nix  # Import Flux configuration (no need to define services.flux again)
  ];

  # System Version
  system.stateVersion = "24.11";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  boot.initrd.availableKernelModules = [
    "ata_piix"
    "ohci_pci"
    "ehci_pci"
    "ahci"
    "sd_mod"
    "sr_mod"
  ];

  boot.loader.grub.device = "/dev/sda";

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "btrfs";
    options = [ "discard" "compress=lzo" ];
  };

  # Disable need for entering password into sudo
  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfree = true;

  nix.maxJobs = 2;
  virtualisation.virtualbox.guest.enable = true;
}
