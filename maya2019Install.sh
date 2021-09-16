#!/bin/bash

#Aleichik Ilya Dzmitrievich, 2021
#Autodesk Maya Installation Bash Script for Ubuntu Unity 20.04 based Linux Distributions

DIR=./maya2019install/

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

mkdir -p maya2019install
cd maya2019install

if [ -f $DIR/Autodesk_Maya_2019_Linux_64bit.tgz ];
then
    cd $DIR
    tar xvf Autodesk_Maya_2019_Linux_64bit.tgz
else
echo “Not File, file should be dowloaded. Wait, please ...”
    wget https://edutrial.autodesk.com/NetSWDLD/2019/MAYA/EC2C6A7B-1F1B-4522-0054-4FF79B4B73B5/ESD/Autodesk_Maya_2019_Linux_64bit.tgz
    tar xvf Autodesk_Maya_2019_Linux_64bit.tgz
fi

apt-get install -y libssl-dev libjpeg62 alien csh tcsh libaudiofile-dev libglw1-mesa elfutils libglw1-mesa-dev mesa-utils xfstt xfonts-100dpi xfonts-75dpi ttf-mscorefonts-installer libfam0 libfam-dev libcurl4-openssl-dev libtbb-dev
apt-get install rpm --reinstall

add-apt-repository ppa:linuxuprising/libpng12 && apt update && apt install libpng12-0
wget -c http://archive.ubuntu.com/ubuntu/pool/main/g/glibc/multiarch-support_2.27-3ubuntu1.4_amd64.deb
wget -c http://ftp.debian.org/debian/pool/main/libx/libxp/libxp6_1.0.2-2_amd64.deb
apt-get install ./multiarch-support_2.27-3ubuntu1.4_amd64.deb ./libxp6_1.0.2-2_amd64.deb
apt install libpcre16-3

alien -cv *.rpm
dpkg -i *.deb
echo "int main (void) {return 0;}" > mayainstall.c
gcc mayainstall.c
mv /usr/bin/rpm /usr/bin/rpm_backup
cp a.out /usr/bin/rpm
chmod +x ./setup
./setup 
rm /usr/bin/rpm
mv /usr/bin/rpm_backup /usr/bin/rpm

cp libQt* /usr/autodesk/maya2019/lib/
cp libadlm* /usr/lib/x86_64-linux-gnu/

ln -s /usr/lib/x86_64-linux-gnu/libtiff.so.5.3.0 /usr/lib/libtiff.so.3
ln -s /usr/lib/x86_64-linux-gnu/libssl.so.1.0.0 /usr/autodesk/maya2019/lib/libssl.so.10
ln -s /usr/lib/x86_64-linux-gnu/libcrypto.so /usr/autodesk/maya2019/lib/libcrypto.so.10
ln -s /usr/lib/x86_64-linux-gnu/libtbb.so.2 /usr/lib/x86_64-linux-gnu/libtbb_preview.so.2
ln -s /usr/lib/x86_64-linux-gnu/libpcre16.so.3 /usr/autodesk/maya2019/lib/libpcre16.so.0

mkdir -p /usr/tmp
chmod 777 /usr/tmp

mkdir -p ~/maya/2019/
chmod 777 ~/maya/2019/

echo "MAYA_DISABLE_CIP=1" >> ~/maya/2019/Maya.env

echo "LC_ALL=C" >> ~/maya/2019/Maya.env

chmod 777 ~/maya/2019/Maya.env

gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier "<Super>"

xset +fp /usr/share/fonts/X11/100dpi/
xset +fp /usr/share/fonts/X11/75dpi/
xset fp rehash

wget https://sourceforge.net/projects/libpng/files/libpng15/1.5.30/libpng-1.5.30.tar.gz
tar zxvf libpng-1.5.30.tar.gz
./libpng-1.5.30/configure 
make
make install
cp /usr/local/lib/libpng15.so.15 /usr/autodesk/maya2019/lib/libpng15.so.15

chmod -R 777 /opt/Autodesk && \
chmod -R 777 /opt/flexnetserver/ && \
chmod -R 777 /usr/autodesk/ && \
chmod -R 777 /var/opt/Autodesk/ && \

#cd .. && rm -r -f ./maya2019install

cp libcrypto.so.1.0.2 libssl.so.10 /usr/lib/x86_64-linux-gnu

echo Autodesk Maya 2019 was installed successfully.
