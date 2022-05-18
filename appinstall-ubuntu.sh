if [ `whoami` != root ]; then
    echo Please run this script using sudo
    echo Just type “sudo !!”
    exit
fi

if [uname -m != x86_64]; then
    echo Maya will only run on 64-bit linux. 
    echo Please install the 64-bit ubuntu and try again.
    exit
fi

sudo timedatectl set-local-rtc 1 --adjust-system-clock

#REMOVE SNAP
sudo systemctl stop snapd && sudo systemctl disable snapd
sudo apt purge snapd
rm -rf ~/snapsudo rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd /usr/lib/snapd /root/snap


#REPOSITORY DEFINE
sudo add-apt-repository ppa:agornostal/ulauncher 
sudo add-apt-repository ppa:appimagelauncher-team/stable
#REPOSITORY DEFINE END

git config --global user.name
git config --global user.email
git clone git@github.com:vinceliuice/vimix-gtk-themes.git
sudo ./vimix-gtk-themes/install.sh -c dark -t doder -s compact
git clone git@github.com:vinceliuice/WhiteSur-icon-theme.git
sudo ./WhiteSur-icon-theme/install.sh

#APT
echo APT Apps Install  ...\n
sudo apt install ulauncher,git,unrar,appimagelauncher
#APT END 

###PATH
sudo cp -f /patch/crack/winewrapper.exe.so /opt/cxoffice/lib/wine/ &&
sudo cp -f ./patch/bitwig.jar /opt/bitwig-studio/bin/ &&
###PATH END

sudo dpkg -i ./*.deb && \

##FIX
sudo apt --fix-broken install &&

#LIBS
echo Drivers and Packages Install ...\n
sudo apt install --reinstall linux-generic && \
sudo apt install lib32z1 && \
sudo apt install xserver-xorg-input-synaptics
sudo ubuntu-drivers autoinstall && \
sudo reboot
echo Drivers and Packages Installed\n
##LIBS END

echo "Application sucessfull installed" || "Instalation filed"

