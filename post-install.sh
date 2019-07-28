#version 0.2
#testing on Fedora 30 now

sudo -s <<EOF

echo "Doing this as root"
dnf install  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf groupupdate core -y
dnf install @kde-desktop -y
dnf remove @gnome-desktop -y
dnf install wget tmux htop net-tools sysstat openssh-server nmap vlc java-openjdk icedtea-web gimp youtube-dl unzip p7zip p7zip-plugins python3-PyQt5 python3 bridge-utils libvirt virt-install qemu-kvm virt-top libguestfs-tools virt-manager virsh transmission discord libreoffice libreoffice-langpack-en libreoffice-langpack-pl aisleriot steam -y
wget https://github.com/mbusb/multibootusb/releases/download/v9.2.0/multibootusb-9.2.0-1.noarch.rpm
rpm -i multibootusb-9.2.0-1.noarch.rpm
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --set-default-zone=drop
systemctl start sshd
systemctl enable sshd
dnf update -y

reboot
EOF