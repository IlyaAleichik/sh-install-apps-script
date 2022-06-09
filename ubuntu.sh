#REPOSITORY DEFINE
sudo add-apt-repository ppa:agornostal/ulauncher 
sudo add-apt-repository ppa:appimagelauncher-team/stable

#REMOVE SNAP
sudo systemctl stop snapd && sudo systemctl disable snapd
sudo apt purge snapd
rm -rf ~/snapsudo rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd /usr/lib/snapd /root/snap

#APT
echo APT Apps Install  ...\n
sudo apt install ulauncher git unrar appimagelauncher dconf-editor alacarte

##GIT SETTINGS
git config --global user.name IlyaAleichik  
git config --global user.email ilya.alejchik@outlook.com
git clone git@github.com:vinceliuice/vimix-gtk-themes.git
sudo ./vimix-gtk-themes/install.sh -c dark -t doder -s compact
git clone git@github.com:vinceliuice/WhiteSur-icon-theme.git
sudo ./WhiteSur-icon-theme/install.sh

##DOTNET
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb 
sudo apt-get install -y apt-transport-https
sudo apt-get install -y dotnet-sdk-2.1 aspnetcore-runtime-2.1
sudo apt-get install -y dotnet-sdk-3.1 aspnetcore-runtime-3.1
sudo apt-get install -y dotnet-sdk-5.0 aspnetcore-runtime-5.0
sudo apt-get install -y dotnet-sdk-6.0 aspnetcore-runtime-6.0

##DOTNET TEMPLATE INSTALL
git clone https://github.com/AvaloniaUI/avalonia-dotnet-templates.git
cd avalonia-dotnet-templates/
dotnet new --install ./

##MSSQL
sudo apt-get install -y mssql-server && 
sudo /opt/mssql/bin/mssql-conf setup && 
systemctl status mssql-server --no-pager &&

###PATH
sudo cp -f /patch/crack/winewrapper.exe.so /opt/cxoffice/lib/wine/ &&
sudo cp -f ./patch/bitwig.jar /opt/bitwig-studio/bin/ &&

##FIX
sudo timedatectl set-local-rtc 1 --adjust-system-clock ##fix localtime linux
sudo apt --fix-broken install

#DRIVERS AND LIBS
sudo apt install --reinstall linux-generic
sudo apt install lib32z1
sudo apt install xserver-xorg-input-synaptics
sudo ubuntu-drivers autoinstall

echo "Application sucessfull installed" || "Instalation filed"

