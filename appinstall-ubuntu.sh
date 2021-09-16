
if [ `whoami` != root ]; then
    echo Please run this script using sudo
    echo Just type “sudo !!”
    exit
fi

#Check for 64-bit arch
if [uname -m != x86_64]; then
    echo Maya will only run on 64-bit linux. 
    echo Please install the 64-bit ubuntu and try again.
    exit
fi

#Ulauncher
echo Ulauncher Install ...\n
sudo add-apt-repository ppa:agornostal/ulauncher && sudo apt update && sudo apt install ulauncher 

#AppImageLauncher
echo AppImageLauncher Install ...\n
sudo add-apt-repository ppa:appimagelauncher-team/stable
sudo apt-get update
sudo apt-get install appimagelauncher

#APT Apps
echo APT Apps Install  ...\n
sudo apt update && \
sudo apt-get install audacity gnome-photos gnome-books plank && \ 
#SNAP-END 

#SNAP Apps
echo SMAPS Apps Install  ...\n
sudo snap refresh && \
sudo snap install discord && \
sudo snap install skype && \
sudo snap install telegram-desktop && \
sudo snap install wps-2019-snap && \
sudo snap install opentoonz && \
sudo snap install ao && \
sudo snap install simplenote && \
sudo snap install blender --classic && \
sudo snap install clion --classic&& \
sudo snap install rider --classic&& \
sudo snap install intellij-idea-ultimate --classic&& \
sudo snap install android-studio --classic&& \
sudo snap install webstorm --classic&& \
sudo snap install phpstorm --classic&& \
sudo snap install pycharm-professional --classic&& \
sudo snap install datagrip --classic&& \
sudo snap install postman && \
sudo snap install converternow && \
sudo snap install handbrake-jz && \
sudo snap install musescore && \
sudo snap install qbittorrent-arnatious && \
sudo snap install node --classic && \
sudo snap install qalculate
sudo snap install thunderbird
#SNAP-END


##DEB AND RPM
sudo apt update && sudo apt install lib32z1 && 
sudo dpkg -i ./*.deb && 

##Crossover Pathed
sudo cp -f /crack/winewrapper.exe.so /opt/cxoffice/lib/wine/ &&

##Bitwiw Pathed
sudo cp -f ./patch/bitwig.jar /opt/bitwig-studio/bin/ &&

##Fix package
sudo apt --fix-broken install &&

echo "Application sucessfull installed" || "Instalation filed"

