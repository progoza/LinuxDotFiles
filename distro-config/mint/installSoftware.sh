#!/bin/bash

sudo apt install curl software-properties-common apt-transport-https -y

cat /etc/apt/sources.list.d/* > repos.txt

BRAVE_REPO=`cat repos.txt | grep brave | wc -l`

if [ "$BRAVE_REPO" -gt "0" ] ; then
        echo "Brave repo already imported, skipping"
else
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
fi

GOOGLE_REPO=`cat repos.txt | grep google | wc -l`
if [ "$GOOGLE_REPO" -gt "0" ] ; then
	echo "Google repo already imported, skipping"
else
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo add-apt-repository "deb http://dl.google.com/linux/chrome/deb/ stable main"
fi

ONEDRIVE_PPA=`cat repos.txt | grep onedrive | wc -l`
if [ "$ONEDRIVE_PPA" -gt "0" ] ; then
	echo "Onedrive PPA already imported, skipping"
else
        wget -qO - https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /usr/share/keyrings/obs-onedrive.gpg > /dev/null
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/obs-onedrive.gpg] https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_22.04/ ./" | sudo tee /etc/apt/sources.list.d/onedrive.list
fi

MS_EDGE_REPO=`cat repos.txt | grep microsoft | wc -l`
if [ "$MS_EDGE_REPO" -gt "0" ] ; then
        echo "Edge repo already imported, skipping"
else
	curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] http://packages.microsoft.com/repos/edge/ stable main" >> /etc/apt/sources.list.d/microsoft_edge.list'
fi

rm repos.txt

sudo apt update
sudo apt upgrade

echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
echo ttf-mscorefonts-installer msttcorefonts/present-mscorefonts-eula note | sudo debconf-set-selections

cat ~/distro-config/mint/packages-apt.txt | while read package
do
	echo "Installing from apt: $package"
#	sudo apt --assume-yes install $package 
done

cat ~/distro-config/mint/packages-flatpak.txt | while read package
do
        echo "Installing from flatpak: $package"
#        flatpak install -y flathub $package 
done

