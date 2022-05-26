# config for the node
{ config, pkgs, lib, ... }:
{
  imports =
    [
      # hardware info
      ./kvm-configuration.nix
    ];

  # use efi
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # time zone.
  time.timeZone = "America/Toronto";

  networking.useDHCP = false;
  networking.interfaces.ens18.useDHCP = true;

  # set up users
  users.users.blobcode = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINeZA/KtZLgoCxrmi9XFqmuSOdYmAUmZMVDyOnPW5ZhQ" ];
  };

  # allow root to use blob's ssh key
  users.users.root.openssh.authorizedKeys.keys =
    config.users.users.blob.openssh.authorizedKeys.keys;

  # enable ssh
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "yes";
  };

  # DO NOT CHANGE
  system.stateVersion = "21.11";
}
