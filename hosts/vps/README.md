# VPS Config

Configuration information for host VPS

## Nextcloud

To reset, clean paths:

- /persistent/nextcloud/db
- /persistent/nextcloud/home
- /mnt/box/nextcloud/data

Then to re-setup:

- enable default encryption module
- turn on server side encryption
- enter mail password in basic setup
  (should be moved to secrets file)
- set collabora CODE server address
- set allowed WOPI IPs, check log reader or
  use this to find address:
  `cat /var/log/nginx/access.log | grep COOLWSD`
- enable collectives, drawio app
