# kickstart file for kvm-guest

ignoredisk --only-use=vda
# Partition clearing information
clearpart --none --initlabel

# install
# don't use graphical install
text
# look for an installer DVD
cdrom
# Run the Setup Agent on first boot
firstboot --enable

# localization
lang en_GB.UTF-8
timezone Europe/London --isUtc
keyboard uk

# network
network  --bootproto=dhcp --device=enp1s0 --ipv6=auto --activate
network  --hostname=kvm-guest.lab.silvan.uk

# licences, subscriptions and repos
repo --name="AppStream" --baseurl=file:///run/install/repo/AppStream
eula --agreed

# accounts
rootpw --iscrypted $6$SQXqGsYna84.3SL5$gJw6v23ZZ7WEITfBoZmyNDsIKeoqhS2Mwfk.KpCRloK7EfxlhL3MAlTCO33fr7QRfoG.GvBH1seWtQqz5v82q1
user --groups=wheel --name=nick --password=$6$G3GIlnUH.JqcrAQl$I.q7gGoT37tcNnrGiHkeUTBtr8AAuoM/yy3P3FuEpJaSun6clgR8GlvKIbqOTgqNe.fIBV6xZOPiWvsduhXeC/ --iscrypted --gecos="nick"

# disk 
part /boot/efi --fstype="efi"   --ondisk=vda --size=600 --fsoptions="umask=0077,shortname=winnt"
part pv.217    --fstype="lvmpv" --ondisk=vda --size=40175
part /boot     --fstype="xfs"   --ondisk=vda --size=1024
volgroup rhel --pesize=4096 pv.217
logvol /     --fstype="xfs"  --size=1024  --name=root --vgname=rhel --grow
logvol swap  --fstype="swap" --size=256   --name=swap --vgname=rhel

# applications and services 
# Do not configure the X Window System
skipx
services --enabled="chronyd"

# done
# skip anaconda's prompt "Installation complete. Press ENTER to quit:"
reboot


# special install sections

%packages
@^minimal-environment
kexec-tools

%end

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

# password policy (for the anaconda installer, not PAM)
%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end

%post --log=/root/ks-post.log
/usr/sbin/subscription-manager register --username=NAME --password=PASS 
/usr/sbin/subscription-manager attach --pool=1234567890abcdef
/usr/sbin/subscription-manager release --set=8.2
/usr/bin/dnf -y update
%end

