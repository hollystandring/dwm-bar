#!/bin/bash

# A script to apply settings at https://github.com/joestandring/dotfiles and various other changes to a fresh Void Linux install
# Joe Standring <git@joestandring.com>
# GNU GPLv3

echo -e "\e[31mChecking permissions...\e[0m"
if [ "$EUID" -eq 0 ]; then
	echo "Please do not run this script as root (e.g. using sudo)"
	exit
fi

echo -e "\e[31mUpdating and installing packages...\e[0m"
sudo xbps-install -Su
sudo xbps-install -S git neovim neofetch curl wget xorg-minimal calcurse setxkbmap dunst NetworkManager NetworkManager-openvpn network-manager-applet pywal feh pkg-config fontconfig-devel libXinerama-devel libX11-devel libXft-devel ncurses st-terminfo fish-shell compton cmus cmus-flac cmus-pulseaudio pulseaudio alsa-plugins-pulseaudio mpv newsboat ranger transmission socklog-void font-hack-ttf nerd-fonts-ttf make cparser

echo -e "\e[31mCloning dotfiles...\e[0m"
git clone https://github.com/joestandring/dotfiles
mv dotfiles ~/.dot

echo -e "\e[31mMoving files...\e[0m"
cp ~/.dot/.bashrc ~
cp ~/.dot/.xinitrc ~
cp -r ~/.dot/.config ~

echo -e "\e[31mConfiguring Network Manager...\e[0m"
echo 'polkit.addRule(function(action, subject) {
  if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 && subject.isInGroup("network")) {
    return polkit.Result.YES;
  }
});' | sudo tee /etc/polkit-1/rules.d/50-org.freedesktop.NetworkManager.rules

echo -e "\e[31mConfiguring services...\e[0m"
sudo ln -s /etc/sv/socklog-unix /var/service
sudo ln -s /etc/sv/nanoklogd /var/service
sudo rm -rf /var/service/dhcpcd
sudo rm -rf /var/service/wpa_supplicant
sudo ln -s /etc/sv/NetworkManager /var/service
sudo ln -s /etc/sv/dbus /var/service

echo -e "\e[31mFirst time color setup...\n[0m"
wal -i /usr/share/void-artwork/void-logo.png
~/.config/dunst/wal.sh

echo -e "\e[31mBuilding packages...\e[0m"
cd ~/.config/st
sudo make clean install
cd ~/.config/dwm
sudo make clean install
cd ~/.config/dmenu
sudo make clean install

echo -e "\e[31mGetting scripts...\e[0m"
mkdir ~/bin
cd
git clone https://github.com/joestandring/countdown
chmod +x ~/countdown/countdown.sh
mv ~/countdown/countdown.sh ~/bin/countdown
rm -rf ~/countdown
git clone https://github.com/joestandring/void-wiki-cli
chmod +x ~/void-wiki-cli/void_wiki.sh
mv ~/void-wiki-cli/void_wiki.sh ~/bin/void-wiki-cli
rm -rf ~/void-wiki-cli
git clone https://github.com/joestandring/dwm-bar
chmod +x ~/dwm-bar/dwm_bar.sh
mv ~/dwm-bar/dwm_bar.sh ~/bin/dwm-bar
mv ~/dwm-bar/bar-functions ~/bin
rm -rf ~/dwm-bar

echo -e "\e[31Configuring Neovim...\e[0m"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo -e "\e[31Setting up dwm-bar...\e[0m"
echo -e "TO BE ADDED AFTER DWM-BAR-INSTALLER"

echo -e "Finished!\nJust startx to jump right in"
