{ pkgs, pconf, ... }: {
  # Run the rclone command to manually authenticate and configure onedrive
  home.packages = [ pkgs.rclone ];
  #
  systemd.user.services.onedrived = {
    Unit = {
      Description = "Onedrive mount";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = "${pkgs.rclone}/bin/rclone mount onedrive: /home/${pconf.user}/OneDrive --vfs-cache-mode writes --daemon";
      ExecStop = "${pkgs.coreutils}/bin/umount /home/${pconf.user}/OneDrive";
    };
  };
}
