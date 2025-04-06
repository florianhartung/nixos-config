# Sources
# https://nixos.wiki/wiki/Libvirt

{ config, pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    # qemu
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMFFull.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
      };
    };
    # spiceUSBRedirection.enable = true;
  };
  # services.spice-vdagentd.enable = true;

  users.users.flo.extraGroups = [ "libvirtd" ];

}
