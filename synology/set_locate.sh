#!/bin/sh

#ref:  http://www.bärwolff.de/tech-notes/synology-diskstation-howto-set-locale.txt
#I've been using a Synology Diskstation DS209j to backup data via rsync. However, the locale on my laptop (the source of the backups) is de_DE.utf8, 
#and on the Diskstation no such locale (in fact, no utf-8 locale at all) is available by default. This becomes a problem as soon as you're dealing 
#with file names containing "non-standard" characters such as German umlauts. Here's what I did to remedy the problem, largely based on a very useful 
#howto at <http://forum.synology.com/wiki/index.php/CrashPlan_Headless_Client>:

#log in to the Diskstation as root
cd /volume1/@tmp
#uname -a # in order to find out what system you're at, and which tool chain to download from http://sourceforge.net/projects/dsgpl/files/; mine was 
#<http://sourceforge.net/projects/dsgpl/files/DSM%203.2%20Tool%20Chains/Marvell%2088F628x%20Linux%202.6.32/gcc421_glibc25_88f6281-GPL.tgz/download>
#wget $the_url_found_in the_previous_step
wget -c -nc "http://sourceforge.net/projects/dsgpl/files/DSM%204.1%20Tool%20Chains/Marvell%2088F628x%20Linux%202.6.32/gcc421_glibc25_88f6281-GPL.tgz"
#tar -xzvf  $the_file_thus_downloaded
tar -xzvf "gcc421_glibc25_88f6281-GPL.tgz"
#cd $the_dir/$the_dir
cd "arm-none-linux-gnueabi/arm-none-linux-gnueabi"
cp libc/usr/bin/locale /usr/bin 
cp libc/usr/bin/localedef /usr/bin 
cp -r libc/usr/share/i18n /usr/share
mkdir /usr/lib/locale
#localedef -f UTF-8 -i de_DE de_DE.UTF-8 # or en_US en_US.UTF-8 if you so wish 
localedef -f UTF-8 -i en_US en_US.UTF-8
locale -a # should now give you more than C and POSIX


#vi /etc/profile
 # add:
# LANG=de_DE.UTF-8
# LC_ALL=de_DE.UTF-8
# export LANG LC_ALL
#reboot
#done

cat << EOF >> /etc/profile
set_locate(){
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
export LANG LC_ALL
}
set_locate
EOF

echo reboot to finish
