#I am no longer using GNOME Desktop Environment on Fedora and so this script will likely never be updated
#The new script can be found under "post-install.sh", please look to it for updates

echo "Version 0.1
----------------------
Starting version for laptop reinstallation.
Has a basic functionality, will change a few security settings, install tmux, change user and root passwords, and install updates.

You can expect more updates in due time"
sudo -s <<EOF
notify-send "just testing the alert functionality"
echo "I am now in root mode"
sleep 3
clear
echo "Changing firewall policies"
firewall-cmd --set-default-zone=drop
firewall-cmd --list-all
sleep 5
clear
echo "Changing SSH config"
sed -z 's/PermitRootLogin yes\|$/PermitRootLogin no/' /etc/ssh/sshd_config -i
cat /etc/ssh/sshd_config | grep PermitRootLogin
sleep 5
clear
echo "Installing tmux and tweaks"
dnf install tmux gnome-tweaks -y
sleep 5
clear
echo "Changing root password"
echo "UserPassword :)" | passwd --stdin user
echo "100%UnbreakablePassword" | passwd --stdin root
echo $?
echo "Passwords changes were successful, moving on"
sleep 5
clear
dnf update -y
sleep 5
clear
chmod 0000 /bin/su
echo "We are all done here, you're good to go"
EOF
gnome-tweaks
