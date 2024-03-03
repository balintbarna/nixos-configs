# Personal NixOS Configuration

Follow the steps below to apply the build on a new install.

```bash
# you will need the keyfile from another computer that is already authenticated
git-crypt export-key <key-export-path>  # inside the repo root directory
```

```bash
# before cloning you'll need git
nix-shell -p git git-crypt
cd  # go to home directory
git clone git@github.com:balintbarna/nixos-configs.git
cd nixos-configs
git-crypt unlock <key-download-path>
```

```bash
sudo su  # as root
rm /etc/nixos/configuration.nix
# ensure that the file points to the right device file
ln -s /home/balint/nixos-configs/linked/configuration.nix /etc/nixos/configuration.nix
nixos-rebuild switch
```

```bash
# as user
rm ~/.config/home-manager/home.nix
mkdir -p ~/.config/home-manager
ln -s /home/balint/nixos-configs/linked/home.nix ~/.config/home-manager/home.nix
home-manager switch
```


## TODOs

Items needed before a desired state is reached.


### Enable secureboot

Started in secureboot.nix. :
[Quick Start](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md)


### Camera on Surface Pro 6

For some reason the from camera image is just a green blob. The back camera is upside down. :
[Camera Support](https://github.com/linux-surface/linux-surface/wiki/Camera-Support#module-ids-and-sensor-mappings)
:
[SB2 Camera Issue](https://github.com/NixOS/nixos-hardware/issues/523)


### Declarative Accounts Configuration

I don't want to use Evolution to configure my accounts for email calendar and contacts. :
[Guide](https://srid.ca/cli/email)


## Useful Links

[Btrfs Convert](https://archive.kernel.org/oldwiki/btrfs.wiki.kernel.org/index.php/Conversion_from_Ext3/4_and_ReiserFS.html)
:
[LUKS2 Upgrade](https://gist.github.com/Edu4rdSHL/8f97eb1bab454fb2b348f1167cee7cd2)
:
[TPM Enroll](https://discourse.nixos.org/t/full-disk-encryption-tpm2/29454)
:
[Swapfile Hibernate](https://discourse.nixos.org/t/is-it-possible-to-hibernate-with-swap-file/2852/3)
:
[Suspend-then-hibernate](https://discourse.nixos.org/t/suspend-then-hibernate/31953/6)
