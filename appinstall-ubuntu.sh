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

#REPOSITORY DEFINE
sudo add-apt-repository ppa:agornostal/ulauncher 
sudo add-apt-repository ppa:appimagelauncher-team/stable
#REPOSITORY DEFINE END

##UPDATE
sudo apt update && \
sudo apt upgrade && \
##UPDATE END

#APT
echo APT Apps Install  ...\n
sudo apt install ulauncher && \
sudo apt install unrar && \
sudo apt install appimagelauncher && \
#APT END 

#SNAP
echo SMAPS Apps Install  ...\n
sudo snap refresh && \
sudo snap install discord && \
sudo snap install telegram-desktop && \
sudo snap install opentoonz && \
sudo snap install blender --classic && \
sudo snap install android-studio --classic&& \
sudo snap install qbittorrent-arnatious && \
sudo snap install node --classic && \
#SNAP END

##DEB
echo AppImage Apps Install  ...\n
sudo dpkg -i ./*.deb && \
##DEB END

###PATH
sudo cp -f /crack/winewrapper.exe.so /opt/cxoffice/lib/wine/ &&
sudo cp -f ./patch/bitwig.jar /opt/bitwig-studio/bin/ &&
###PATH END

##Fix package
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

