{ pkgs, ... }:
{
  home.packages = [
    # Compression
    pkgs.gnutar
    pkgs.gzip
    pkgs.xz
    pkgs.zip
    pkgs.zstd

    # Inspect
    pkgs.pcmanfm
    pkgs.yazi
    pkgs.bat
    pkgs.file
    pkgs.less
    pkgs.tree

    # Search'n'replace
    pkgs.findutils
    pkgs.gawk
    pkgs.gnugrep
    pkgs.gnused
    pkgs.ripgrep

    # Debugging
    pkgs.lsof
    pkgs.ncdu

    # File system support
    pkgs.bcachefs-tools
    pkgs.btrfs-progs
    pkgs.cryptsetup
    pkgs.dosfstools
    pkgs.exfatprogs
    pkgs.hfsprogs
    pkgs.hfsutils
    pkgs.lvm2
    pkgs.mtools
    pkgs.ntfs3g
    pkgs.xfsprogs
    pkgs.zfs

    # Misc
    pkgs.rsync
    pkgs.socat
  ];
}
