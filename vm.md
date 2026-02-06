# How to creat new VM

## Prebuilt VM

Download the prebuilt Arch Linux VM:

```
https://artfiles.org/archlinux.org/images/latest/Arch-Linux-x86_64-basic.qcow2
```

Save it somewhere on your host:

```
~/vm/name.qcow2
```

## Run the VM

Start the VM with:

```
qemu-system-x86_64 \
  -enable-kvm \
  -cpu host \
  -smp 4 \
  -m 8G \
  -drive file=~/vm/name.qcow2,if=virtio \
  -nographic \
  -netdev user,id=net0,hostfwd=tcp::2222-:22 \
  -device virtio-net,netdev=net0
```

## Install dependencies

On the first boot, SSH into the VM or use the serial console, then install required packages:

```
sudo pacman -S \
  git python docker docker-compose npm postgresql \
  postgresql-libs influx-cli ripgrep less
```

## Connect to the VM

From the host, use SSH to connect to the VM:

```
ssh arch@localhost -p 2222
```

## File manipulation

For editing files, use SSHFS:

```
sshfs -p 2222 arch@localhost:/home/arch ~/vm/mnt
```
