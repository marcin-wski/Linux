#version 0.6
#testing on Fedora 30 now
#It appears that the power management does not currently start properly
#More updates to follow

sudo -s <<EOF

echo "Doing this as root"
dnf install  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf groupupdate core -y
dnf install @kde-desktop -y
dnf remove @gnome-desktop -y
dnf groupremove "GNOME Desktop Environment" -y
dnf remove gdm -y
dnf install wget tmux htop net-tools sysstat openssh-server nmap -y
dnf install vlc java-openjdk icedtea-web gimp youtube-dl -y
dnf install unzip p7zip p7zip-plugins python3-PyQt5 python3 -y
dnf install bridge-utils libvirt virt-install qemu-kvm virt-top libguestfs-tools virt-manager virsh -y
dnf install transmission discord -y
dnf install libreoffice libreoffice-langpack-en libreoffice-langpack-pl -y
dnf install aisleriot steam -y
dnf install nvidia*3:430* -y
dnf install nvidia-texture-tools -y
sudo dnf remove sddm -y
sudo dnf install sddm -y
sudo dnf install kdm -y
wget https://github.com/mbusb/multibootusb/releases/download/v9.2.0/multibootusb-9.2.0-1.noarch.rpm
rpm -i multibootusb-9.2.0-1.noarch.rpm
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --set-default-zone=drop
systemctl start sshd
systemctl enable sshd
firewall-cmd --list-all
sleep 3
dnf update -y

reboot
EOF
