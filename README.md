# Personal NixOS Configuration

Follow the steps below to apply the build on a new install. First you will need the keyfile from another computer that is already authenticated.

```bash
# cd to repo directory
git-crypt export-key <key-export-path>
```

Clone with git.
Unlock secrets with git-crypt.

```bash
nix-shell -p git git-crypt
cd  # go to home directory
git clone git@github.com:balintbarna/nixos-configs.git
cd nixos-configs
git-crypt unlock <key-download-path>
```

Link the correct config file from the repo and rebuild.

```bash
sudo su  # as root
rm /etc/nixos/configuration.nix
ln -s /home/balint/nixos-configs/flake.nix /etc/nixos/flake.nix
nixos-rebuild switch
exit
```

Link the home config file and activate it.

```bash
# as user
mkdir -p ~/.config/home-manager
ln -s /home/balint/nixos-configs/flake.nix ~/.config/home-manager/flake.nix
home-manager switch
```


## Commands

Create a swap file - or just let the config auto-create it for you.

```bash
btrfs filesystem mkswapfile --size <size>g /var/swapfile
```

Find swapfile offset for kernel parameter config.

```bash
filefrag -v /var/swapfile  # not btrfs
btrfs inspect-internal map-swapfile -r /var/swapfile  # btrfs
```

Launch front camera stream on SP6.

```bash
gst-launch-1.0 libcamerasrc camera-name='\\\_SB_.PCI0.I2C2.CAMF' ! videoconvert ! v4l2sink device=/dev/video0
```

Enroll auto-unlock of encrypted filesystem.
If you are stuck on LUKS1 see guide below.

```bash
blkid | grep crypto  # Find device
systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+1+2+3+7 <luks2-partition>  # Enroll
```

> Plymouth boot splash screen option will hide boot text preventing you from entering the encryption password. Make sure to setup auto-unlock first.


## TODOs

Items needed before a desired state is reached.


### Camera on Surface Pro 6

The front camera image is just a green blob. The back camera is upside down. The font camera works with userspace libraries, requires running a terminal command to activate it. It's (not) mirrored and the picture quality is bad.
:
[Camera Support](https://github.com/linux-surface/linux-surface/wiki/Camera-Support#module-ids-and-sensor-mappings)
:
[SB2 Camera Issue](https://github.com/NixOS/nixos-hardware/issues/523)


### Declarative Accounts Configuration

I don't want to use Evolution to configure my accounts for email calendar and contacts. It seems like the home manager accounts module doesn't work well with gnome software.


## Useful Links

[Secure Boot](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md)
:
[Btrfs Convert](https://archive.kernel.org/oldwiki/btrfs.wiki.kernel.org/index.php/Conversion_from_Ext3/4_and_ReiserFS.html)
:
[LUKS2 Upgrade](https://gist.github.com/Edu4rdSHL/8f97eb1bab454fb2b348f1167cee7cd2)
:
[TPM Enroll](https://discourse.nixos.org/t/full-disk-encryption-tpm2/29454)
:
[Swapfile Hibernate](https://discourse.nixos.org/t/is-it-possible-to-hibernate-with-swap-file/2852/3)
:
[Suspend-then-hibernate](https://discourse.nixos.org/t/suspend-then-hibernate/31953/6)
