install
text
reboot
#uncomment the #cdrom line and comment the url one for installs from DVD
cdrom
#use a mirror close to you or even better, the local one provided by your organization
#replace x86_64 with i386 for 32bit installs
#url --url http://mirror.centos.org/centos/6/os/x86_64

lang en_US.UTF-8
keyboard us
skipx
rootpw vagrant
timezone --utc America/New_York

network --device eth0 --bootproto dhcp

clearpart --all --drives=sda
bootloader --location=mbr
autopart

#bootloader --location=mbr --driveorder=sda
#part /boot --fstype=ext4 --size=500
#part pv.1 --grow --size=1
#volgroup vg_primary --pesize=4096 pv.1
#logvol / --fstype=ext4 --name=lv_root --vgname=vg_primary --grow=1024 --maxsize=51200
#logvol swap --name=lv_swap --vgname=vg_primary --grow --size=1504

%packages --nobase --excludedocs
coreutils
curl
bzip2
yum
rpm
e2fsprogs
lvm2
grub
openssh-server
openssh-clients
dhclient
sudo

%post --log=/root/kickstart-post.log
set -x

# Setup defaults for vagrant: user, sudo, ssh key
groupadd admin
useradd -G admin -p $(openssl passwd -1 vagrant) vagrant
echo '
Defaults    env_keep += SSH_AUTH_SOCK 
%admin ALL=NOPASSWD: ALL
Defaults:vagrant !requiretty
' > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant
sudo -u vagrant mkdir /home/vagrant/.ssh 
sudo -u vagrant curl -k https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub > /home/vagrant/.ssh/authorized_keys
chmod 0755 /home/vagrant/.ssh
chmod 0644 /home/vagrant/.ssh/authorized_keys

# Insert Script to easily update and install latest guest additions
scriptUpdate=updateBaseBox
scriptInstallGuestAdditions=installVBoxGuestAdditions
mkdir /root/bin

###################################
#  Install Script: updateBaseBox  #
###################################
echo "#!/bin/bash
yum -y upgrade

echo on reboot guest additions will be downloaded and rebuilt

cat >/etc/init.d/$scriptInstallGuestAdditions <<EOF
#!/bin/bash
#
# $scriptInstallGuestAdditions  Re-Install VirtualBox Guest Additions
#
# chkconfig: 2345 99 99
# description: This script will install dependancies for VirtualBox Guest Additions \
#              install the additions and then remove the dependancies

# Install guest additions
/root/bin/$scriptInstallGuestAdditions
# Remove self from startup
chkconfig $scriptInstallGuestAdditions off
chkconfig --del $scriptInstallGuestAdditions
# Remove initscript
rm -f /etc/init.d/$scriptInstallGuestAdditions
EOF

# Set script to run on next boot
chmod +x /etc/init.d/$scriptInstallGuestAdditions
chkconfig --add $scriptInstallGuestAdditions
chkconfig $scriptInstallGuestAdditions on
# Reboot after upgrade
reboot
" > /root/bin/$scriptUpdate
chmod +x /root/bin/$scriptUpdate

##################################################
#  Install Script: Install VBox Guest Additions  #
##################################################

echo '#!/bin/bash
# This script installs the latest VirtualBox Guest Additions
# It installs the required build dependancies, installs the additions
# then removes the build deps

yum -y install dmidecode gcc make kernel-devel-$(uname -r) kernel-headers-$(uname -r) perl 
#LATEST_VBOX=$(curl --silent http://download.virtualbox.org/virtualbox/LATEST.TXT) && echo downloading virtualbox vuest additions for $LATEST_VBOX
vboxVer=$(dmidecode | grep vboxVer | sed 's/.*vboxVer_//gi')
ISO=VBoxGuestAdditions_$vboxVer.iso
curl --remote-name --location http://download.virtualbox.org/virtualbox/$vboxVer/$ISO
mount -o loop $ISO /mnt
/mnt/VBoxLinuxAdditions.run
yum -y clean all
umount /mnt
rm $ISO
' > /root/bin/$scriptInstallGuestAdditions
chmod +x /root/bin/$scriptInstallGuestAdditions
##################################

# Cleanup things that might be taking disk space
yum clean all

#chkconfig --add $scriptInstallGuestAdditions
#chkconfig $scriptInstallGuestAdditions on

%end

