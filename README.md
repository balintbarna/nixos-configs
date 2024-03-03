# Personal NixOS Configuration

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
