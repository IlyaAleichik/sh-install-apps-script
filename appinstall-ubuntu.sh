
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg &&
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ &&
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' &&
rm -f packages.microsoft.gpg && \

sudo add-apt-repository ppa:go-for-it-team/go-for-it-stable 

########################################################## APT

sudo apt update && \
sudo apt-get install -y apt-transport-https && \
sudo apt update && \

sudo apt-get install code gnome-photos gnome-books unrar rclone  celluloid qbittorrent thunderbird krita inkscape darktable code go-for-it dotnet-sdk-5.0 aspnetcore-runtime-5.0 npm nasm clang python lua5.3 openjdk-8-jdk openjdk-8-jre git scribus qemu-kvm libvirt-daemon libvirt-daemon-system libvirt-daemon-driver-qemu gir1.2-spiceclientgtk-3.0 virt-manager ovmf hardinfo

########################################################## SNAP
sudo snap install discord && \
sudo snap install skype && \
sudo snap install telegram-desktop && \
sudo snap install wps-2019-snap && \
sudo snap install figma-linux && \
sudo snap install opentoonz && \
sudo snap install ao && \
sudo snap install simplenote && \
sudo snap install blender && \
sudo snap install clion && \
sudo snap install rider && \
sudo snap install intellij-idea-ultimate && \
sudo snap install android-studio && \
sudo snap install webstorm && \
sudo snap install phpstorm && \
sudo snap install pycharm-professional && \
sudo snap install datagrip && \
sudo snap install postman && \
sudo snap install converternow && \
sudo snap install handbrake-jz && \
sudo snap install musescore && \

########################################################## DEB AND RPM
