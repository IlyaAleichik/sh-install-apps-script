#disabled - Krita

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg &&
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ &&
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' &&
rm -f packages.microsoft.gpg && \

wget https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb &&
sudo dpkg -i packages-microsoft-prod.deb &&
rm packages-microsoft-prod.deb &&

#sudo add-apt-repository ppa:go-for-it-team/go-for-it-stable 
########################################################## APT

sudo apt update && \
sudo apt-get install -y apt-transport-https && \
sudo apt update && sudo apt install -y dotnet-sdk-5.0 aspnetcore-runtime-5.0 && \
sudo apt-get install audacity code gnome-photos gnome-books unrar rclone celluloid thunderbird inkscape darktable code npm nasm clang lua5.3 hardinfo && \ 

########################################################## SNAP

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
sudo snap install qbittorrent-arnatious;


########################################################## DEB AND RPM
