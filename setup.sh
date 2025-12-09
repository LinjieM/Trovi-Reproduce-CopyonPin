#!/bin/bash
set -x

USE_KERNEL="relcop"

pushd .
cd ~
git clone https://gitlab.com/cop_paper/ae.git

sudo apt install -y gcc patch make wget git bc tar libssl-dev openssl flex bison libelf-dev\
                    zstd libzstd-dev numactl libnuma-dev libnsl-dev gfortran build-essential g++ || { echo 'installing packages failed' ; exit 1; }

cd ae/kernels
sed -i '9s|.*|#|' ./install.sh
sed -i '10s|.*|#|' ./install.sh
sed -i '19s|.*|KERNELS=("'$USE_KERNEL'")|' ./install.sh
sed -i '34s|-j20|-j`nproc`|' ./install.sh

sudo ./install.sh

sudo touch /swapfile
sudo chmod 600 /swapfile
sudo dd if=/dev/zero of=/swapfile bs=1M count=2048
sudo mkswap /swapfile
sudo swapon /swapfile
echo "/swapfile swap swap defaults 0 0" | sudo tee -a /etc/fstab

sudo sed -i '6s|.*|GRUB_DEFAULT="1>0"|' /etc/default/grub
sudo update-grub

popd