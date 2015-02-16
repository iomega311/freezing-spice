#!/bin/bash

xPrompt()
{
clear
echo "Media Server Setup:"
echo ""
echo ""
echo "Choose a number to install: "
echo ""
echo "1) Upgrade/Update your Ubuntu Server distro"
echo "WARNING... THIS PROCESS COULD TAKE A LONG TIME"
echo ""
echo "2) SSH Setup"
echo "(used for remote server administration)"
echo ""
echo "3) Install USB Mount" 
echo "(very handy for automatically mounting and unmounting your USB storage device)"
echo ""
echo "4) Install/Setup Samba file share" 
echo "(easily add, re-order, remove your media from your windows/mac machine)"
echo ""
echo "5) Install temperature monitor" 
echo "(keep track of the temperature of your server)"
echo ""
echo "6) Install/Setup Webmin" 
echo "(easily monitor and manage your server via web application)"
echo ""
echo "7) Install Plex Media Server"
echo ""
echo "8) Install/Setup Transmission torrent client" 
echo "(used to download torrents on your server)"
echo ""
echo "9) Install all of the above minus Update/Upgrade option"
echo ""
echo "10) Install everything, including Update/Upgrade option"
echo ""
echo "11) Forget the whole thing and just exit..."
echo ""
echo "(NOTE: After installing packages, restarting is suggested)"
echo ""
echo -n ":"
xControl
}

xReturn()
{
clear
echo "Choose another number to install: "
echo ""
echo ""
echo "1) Upgrade/Update your Ubuntu Server distro"
echo "WARNING... THIS PROCESS COULD TAKE A LONG TIME"
echo ""
echo "2) SSH Setup"
echo "(used for remote server administration)"
echo ""
echo "3) Install USB Mount"
echo "(very handy for automatically mounting and unmounting your USB storage device)"
echo ""
echo "4) Install/Setup Samba file share"
echo "(easily add, re-order, remove your media from your windows/mac machine)"
echo ""
echo "5) Install temperature monitor"
echo "(keep track of the temperature of your server)"
echo ""
echo "6) Install/Setup Webmin"
echo "(easily monitor and manage your server via web application)"
echo ""
echo "7) Install Plex Media Server"
echo ""
echo "8) Install/Setup Transmission torrent client"
echo "(used to download torrents on your server)"
echo ""
echo "9) Install all of the above minus Update/Upgrade option"
echo ""
echo "10) Install everything, including Update/Upgrade option"
echo ""
echo "11) Forget the whole thing and just exit..."
echo ""
echo -n ":"
xControl
}

xUpd()
{
echo "UPDATING APT-GET"
sudo apt-get -y update
echo "UPGRADING DISTRO... THIS MAY TAKE A WHILE"
sudo apt-get -y upgrade
echo "Update and Upgrade were Successful"
xChoice
}

xUpd2()
{
echo "UPDATING APT-GET"
sudo apt-get -y update
echo "UPGRADING DISTRO... THIS MAY TAKE A WHILE"
sudo apt-get -y upgrade
echo "Update and Upgrade were Successful"
}

xSSH()
{
echo "INSTALLING SSH"
sudo apt-get -y update
sudo apt-get -y install ssh
echo "Install of SSH complete."
xChoice
}

xSSH2()
{
echo "INSTALLING SSH"
sudo apt-get -y update
sudo apt-get -y install ssh
echo "Install of SSH complete."
}

xUSB()
{
echo "INSTALLING USB MOUNT"
sudo apt-get -y update
sudo apt-get -y install usbmount
echo "Done"
echo ""
echo "Install of USB Mount successful"
xChoice 
}

xUSB2()
{
echo "INSTALLING USB MOUNT"
sudo apt-get -y update
sudo apt-get -y install usbmount
echo "Done"
echo ""
echo "Install of USB Mount successful"
}

xAdditional()
{
echo "Please pick a name for your additional Samba share"
echo -n ":"
read sharename
echo "Now creating your additional Samba share"
sleep 1
echo "Backing up smb.conf to smb.conf.bak"
sleep 1
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
sudo chmod 777 /etc/samba/smb.conf
echo "Inserting required settings..."
sleep 1
sudo sed -i 's/^#   security = user/    security = share/' /etc/samba/smb.conf
sudo echo "[$sharename]">>/etc/samba/smb.conf
sudo echo "path = /media/usb/">>/etc/samba/smb.conf
sudo echo "comment = $sharename">>/etc/samba/smb.conf
sudo echo "create mask = 0777">>/etc/samba/smb.conf
sudo echo "directory mask = 0777">>/etc/samba/smb.conf
sudo echo "inherit permissions = Yes">>/etc/samba/smb.conf
sudo echo "guest ok = Yes">>/etc/samba/smb.conf
sudo echo "read only = no">>/etc/samba/smb.conf
sudo echo "writeable = yes">>/etc/samba/smb.conf
sudo echo "force user = root">>/etc/samba/smb.conf
sudo echo "force group = root">>/etc/samba/smb.conf
sudo chmod 644 /etc/samba/smb.conf
echo "settings updated"
echo "Your share $sharename has been created in the samba.conf file."
echo "You can edit/view the conf file located at /etc/samba/smb.conf"
echo "Restarting Samba service"
sleep 1
sudo service smbd restart
echo "Did you want to setup an additional share? (y/n)"
echo -n ":"
while [ 1 ]
do
	read choice
	case "$choice" in
	"y")
		echo "'$sharename' has been created"
	    xAdditional
	    ;;
	"n")
	echo "'$sharename' has been created"
	xChoice    
	    ;;
	esac
done
}

xSamba()
{
sudo apt-get -y update
echo "INSTALLING SAMBA FILE SHARE"
sudo apt-get -y install samba
echo ""
echo ""
echo "Your samba file share will create a folder visible on your network"
echo "You will want a name that is recognizable on your network"
echo ""
echo "Please pick a name for your Samba share"
echo -n ":"
read sharename
echo "Now creating your samba share"
sleep 1
echo "Backing up smb.conf to smb.conf.bak"
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
sudo chmod 777 /etc/samba/smb.conf
echo "Inserting required settings..."
sudo sed -i 's/^#   security = user/    security = share/' /etc/samba/smb.conf
sudo echo "[$sharename]">>/etc/samba/smb.conf
sudo echo "path = /media/usb/">>/etc/samba/smb.conf
sudo echo "comment = $sharename">>/etc/samba/smb.conf
sudo echo "create mask = 0777">>/etc/samba/smb.conf
sudo echo "directory mask = 0777">>/etc/samba/smb.conf
sudo echo "inherit permissions = Yes">>/etc/samba/smb.conf
sudo echo "guest ok = Yes">>/etc/samba/smb.conf
sudo echo "read only = no">>/etc/samba/smb.conf
sudo echo "writeable = yes">>/etc/samba/smb.conf
sudo echo "force user = root">>/etc/samba/smb.conf
sudo echo "force group = root">>/etc/samba/smb.conf
sudo chmod 644 /etc/samba/smb.conf
echo "settings updated"
echo ""
echo "Your share '$sharename' has been created in the samba.conf file"
echo "You can edit/view the conf file located at /etc/samba/smb.conf"
echo "Restarting Samba service"
sudo service smbd restart
sleep 1
echo ""
echo "**REMEMBER**"
echo "Your share will link directly to any USB storage device connected to your server"
echo "If you do not have a USB storage device attached, your share will not show anything"
echo ""
echo "Did you want to setup an additional share? (y/n)"
echo -n ":"
while [ 1 ]
do
	read choice
	case "$choice" in
	"y")
		echo "'$sharename' has been created"
	    xAdditional
	    ;;
	"n")
	echo "'$sharename' has been created"
	xChoice    
	    ;;
	esac
done
}

xSamba2()
{
sudo apt-get -y update
echo "INSTALLING SAMBA FILE SHARE"
sudo apt-get -y install samba
echo "Please pick a name for your Samba share"
read sharename
echo "Now creating your samba share"
sleep 1
echo "Backing up smb.conf to smb.conf.bak"
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
sudo chmod 777 /etc/samba/smb.conf
echo "Inserting required settings..."
sudo sed -i 's/^#   security = user/    security = share/' /etc/samba/smb.conf
sudo echo "[$sharename]">>/etc/samba/smb.conf
sudo echo "path = /media/usb/">>/etc/samba/smb.conf
sudo echo "comment = $sharename">>/etc/samba/smb.conf
sudo echo "create mask = 0777">>/etc/samba/smb.conf
sudo echo "directory mask = 0777">>/etc/samba/smb.conf
sudo echo "inherit permissions = Yes">>/etc/samba/smb.conf
sudo echo "guest ok = Yes">>/etc/samba/smb.conf
sudo echo "read only = no">>/etc/samba/smb.conf
sudo echo "writeable = yes">>/etc/samba/smb.conf
sudo echo "force user = root">>/etc/samba/smb.conf
sudo echo "force group = root">>/etc/samba/smb.conf
sudo chmod 644 /etc/samba/smb.conf
echo "settings updated"
echo "$sharename has been created in the samba.conf file"
echo "You can edit/view the conf file located at /etc/samba/smb.conf"
echo "Restarting Samba service"
sudo service smbd restart
echo ""
sleep 1
echo "**REMEMBER**"
echo "Your share will link directly to any USB storage device connected to your server"
echo "If you do not have a USB storage device attached, your share will not show anything"
echo ""
echo "Samba file share complete"
}

xTemp()
{
sudo apt-get -y update
echo "Installing Temperature Monitor"
sudo apt-get -y install lm-sensors
echo "Temperature Sensor install complete"
xChoice
}

xTemp2()
{
sudo apt-get -y update
echo "Installing Temperature Monitor"
sudo apt-get -y install lm-sensors
echo "Temperature Sensor install complete"
}

xWebmin()
{
echo "First... making sure you're up to date..."
sudo apt-get -y update
echo "Installing Webmin v1.730"
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.730_all.deb
sudo apt-get -y update
sudo apt-get -y install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl libapt-pkg-perl apt-show-versions
sudo dpkg -i webmin_1.730_all.deb
sudo apt-get -y install -f
rm webmin_1.730_all.deb
echo "The default username is 'root'."
echo "Please enter your desired password"
echo -n ":"
read newpass
sudo /usr/share/webmin/changepass.pl /etc/webmin root $newpass
echo "Finished installing Webmin v1.730." 
xChoice
}

xWebmin2()
{
echo "First... making sure you're up to date..."
sudo apt-get -y update
echo "Installing Webmin v1.730"
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.730_all.deb
sudo apt-get -y update
sudo apt-get -y install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl libapt-pkg-perl apt-show-versions
sudo dpkg -i webmin_1.730_all.deb
sudo apt-get -y install -f
echo "The default username is 'root'."
echo "Please enter your desired password"
echo -n ":"
read newpass
sudo /usr/share/webmin/changepass.pl /etc/webmin root $newpass
rm webmin_1.730_all.deb
echo "Finished installing Webmin v1.730."
}

xPlex()
{
sudo apt-get -y update
echo "Updating your sources.list"
sudo chmod 777 /etc/apt/sources.list
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo echo "deb http://plex.r.worldssl.net/PlexMediaServer/ubuntu-repo lucid main">>/etc/apt/sources.list
sudo chmod 644 /etc/apt/sources.list
echo "Installing Plex Media Server"
sudo apt-get -y update
sudo apt-get -y install plexmediaserver
sudo cp /etc/apt/sources.list.bak /etc/apt/sources.list.bak.bak
sudo chmod 777 /etc/apt/sources.list
sudo mv /etc/apt/sources.list.bak /etc/apt/sources.list
sudo mv /etc/apt/sources.list.bak.bak /etc/apt/sources.list.bak
sudo chmod 644 /etc/apt/sources.list
sudo chmod 644 /etc/apt/sources.list.bak
sudo service plexmediaserver restart
echo ""
echo "Updating Plex to v0.9.11.7.803 (current as of Feb 2015)"
echo ""
echo "Downloading Plex install package."
wget https://downloads.plex.tv/plex-media-server/0.9.11.7.803-87d0708/plexmediaserver_0.9.11.7.803-87d0708_amd64.deb
echo "Installing Plex v0.9.11.7.803"
sudo dpkg -i plexmediaserver_0.9.11.7.803-87d0708_amd64.deb
sudo rm plexmediaserver_0.9.11.7.803-87d0708_amd64.deb
sudo service plexmediaserver restart
sleep 1
echo ""
echo ""
echo "Plex is now installed. You can now start setting it up by opening up your browser,"
echo "and then navigating to <ip_address>:32400/web/index.html..."
echo ""
echo ""
sleep 5
echo "Finished installing Plex"
xChoice
}

xPlex2()
{
sudo apt-get -y update
echo "Updating your sources.list"
sudo chmod 777 /etc/apt/sources.list
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo echo "deb http://plex.r.worldssl.net/PlexMediaServer/ubuntu-repo lucid main">>/etc/apt/sources.list
sudo chmod 644 /etc/apt/sources.list
echo "Installing Plex Media Server"
sudo apt-get -y update
sudo apt-get -y install plexmediaserver
sudo cp /etc/apt/sources.list.bak /etc/apt/sources.list.bak.bak
sudo chmod 777 /etc/apt/sources.list
sudo mv /etc/apt/sources.list.bak /etc/apt/sources.list
sudo mv /etc/apt/sources.list.bak.bak /etc/apt/sources.list.bak
sudo chmod 644 /etc/apt/sources.list
sudo chmod 644 /etc/apt/sources.list.bak
sudo service plexmediaserver restart
echo ""
echo "Updating Plex to v0.9.11.7.803 (current as of Feb 2015)"
echo ""
echo "Downloading Plex install package."
wget https://downloads.plex.tv/plex-media-server/0.9.11.7.803-87d0708/plexmediaserver_0.9.11.7.803-87d0708_amd64.deb
echo "Installing Plex v0.9.11.7.803"
sudo dpkg -i plexmediaserver_0.9.11.7.803-87d0708_amd64.deb
sudo rm plexmediaserver_0.9.11.7.803-87d0708_amd64.deb
sudo service plexmediaserver restart
sleep 1
echo ""
echo ""
echo "Plex is now installed. You can now start setting it up by opening up your browser,"
echo "and then navigating to <ip_address>:32400/web/index.html..."
echo ""
echo ""
sleep 5
echo "Finished installing Plex"
}

xTrans()
{
sudo apt-get -y update
echo "This will install the Transmission torrent client"
sudo apt-get -y install python-software-properties
sudo add-apt-repository ppa:transmissionbt/ppa
sudo apt-get -y update
sudo apt-get -y install transmission-cli transmission-common transmission-daemon
sudo mkdir ~/Downloads
sudo mkdir ~/Downloads/Completed
sudo mkdir ~/Downloads/Incomplete
sudo mkdir ~/Downloads/Torrents
sudo usermod -a -G debian-transmission $USER
sudo chgrp -R debian-transmission /home/$USER/Downloads
sudo chmod -R 775 /home/$USER/Downloads
sudo /etc/init.d/transmission-daemon stop
sudo chmod 777 /etc/transmission-daemon/settings.json
sudo cp /etc/transmission-daemon/settings.json /etc/transmission-daemon/settings.json.bak
sudo chmod 777 /etc/transmission-daemon/settings.json.bak
sudo touch /etc/transmission-daemon/settings.json.bak.bak
sudo chmod 777 /etc/transmission-daemon/settings.json.bak.bak
sudo echo "Pick a username for Transmission"
read xusername
sudo echo -n ":"
sudo echo "Pick a password for Transmission"
read xpassword
sudo echo -n ":"
sudo echo "{">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"alt-speed-down\": 50,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"alt-speed-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"alt-speed-time-begin\": 540,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"alt-speed-time-day\": 127,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"alt-speed-time-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"alt-speed-time-end\": 1020,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"alt-speed-up\": 50,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"bind-address-ipv4\": \"0.0.0.0\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"bind-address-ipv6\": \"::\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"blocklist-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"blocklist-url\": \"http://www.example.com/blocklist\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"cache-size-mb\": 4,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"dht-enabled\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"download-dir\": \"/home/$USER/Downloads/Complete\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"download-limit\": 100,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"download-limit-enabled\": 0,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"download-queue-enabled\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"download-queue-size\": 5,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"encryption\": 1,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"idle-seeding-limit\": 30,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"idle-seeding-limit-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"incomplete-dir\": \"/home/$USER/Downloads/Incomplete\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"incomplete-dir-enabled\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"lpd-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"max-peers-global\": 200,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"message-level\": 2,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-congestion-algorithm\": \"\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-id-ttl-hours\": 6,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-limit-global\": 200,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-limit-per-torrent\": 50,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-port\": 51413,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-port-random-high\": 65535,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-port-random-low\": 49152,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-port-random-on-start\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-socket-tos\": \"default\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"pex-enabled\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"port-forwarding-enabled\": false, ">>/etc/transmission-daemon/settings.json.bak.bak   
    sudo echo "\"preallocation\": 1,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"prefetch-enabled\": 1,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"queue-stalled-enabled\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"queue-stalled-minutes\": 30,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"ratio-limit\": 2,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"ratio-limit-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rename-partial-files\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-authentication-required\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-bind-address\": \"0.0.0.0\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-enabled\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-password\": \"$xpassword\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-port\": 9091,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-url\": \"/transmission/\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-username\": \"$xusername\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-whitelist\": \"127.0.0.1\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-whitelist-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"scrape-paused-torrents-enabled\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"script-torrent-done-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"script-torrent-done-filename\": \"\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"seed-queue-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"seed-queue-size\": 10,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"speed-limit-down\": 100,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"speed-limit-down-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"speed-limit-up\": 100,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"speed-limit-up-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"start-added-torrents\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"trash-original-torrent-files\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"umask\": 18,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"upload-limit\": 100,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"upload-limit-enabled\": 0,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"upload-slots-per-torrent\": 14,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"utp-enabled\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"watch-dir\": \"/home/$USER/Downloads/Torrents\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"watch-dir-enabled\": true">>/etc/transmission-daemon/settings.json.bak.bak
sudo echo "}">>/etc/transmission-daemon/settings.json.bak.bak
sudo mv /etc/transmission-daemon/settings.json.bak.bak /etc/transmission-daemon/settings.json
sudo chmod 644 /etc/transmission-daemon/settings.json
sudo chmod 644 /etc/transmission-daemon/settings.json.bak
sudo /etc/init.d/transmission-daemon start
echo "Transmission installed."
xChoice
}

xTrans2()
{
sudo apt-get -y update
echo "This will install the Transmission torrent client"
sudo apt-get -y install python-software-properties
sudo add-apt-repository ppa:transmissionbt/ppa
sudo apt-get -y update
sudo apt-get -y install transmission-cli transmission-common transmission-daemon
sudo mkdir ~/Downloads
sudo mkdir ~/Downloads/Completed
sudo mkdir ~/Downloads/Incomplete
sudo mkdir ~/Downloads/Torrents
sudo usermod -a -G debian-transmission $USER
sudo chgrp -R debian-transmission /home/$USER/Downloads
sudo chmod -R 775 /home/$USER/Downloads
sudo /etc/init.d/transmission-daemon stop
sudo chmod 777 /etc/transmission-daemon/settings.json
sudo cp /etc/transmission-daemon/settings.json /etc/transmission-daemon/settings.json.bak
sudo chmod 777 /etc/transmission-daemon/settings.json.bak
sudo touch /etc/transmission-daemon/settings.json.bak.bak
sudo chmod 777 /etc/transmission-daemon/settings.json.bak.bak
sudo echo "Pick a username for Transmission"
read xusername
sudo echo -n ":"
sudo echo "Pick a password for Transmission"
read xpassword
sudo echo -n ":"
sudo echo "{">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"alt-speed-down\": 50,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"alt-speed-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"alt-speed-time-begin\": 540,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"alt-speed-time-day\": 127,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"alt-speed-time-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"alt-speed-time-end\": 1020,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"alt-speed-up\": 50,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"bind-address-ipv4\": \"0.0.0.0\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"bind-address-ipv6\": \"::\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"blocklist-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"blocklist-url\": \"http://www.example.com/blocklist\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"cache-size-mb\": 4,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"dht-enabled\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"download-dir\": \"/home/$USER/Downloads/Complete\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"download-limit\": 100,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"download-limit-enabled\": 0,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"download-queue-enabled\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"download-queue-size\": 5,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"encryption\": 1,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"idle-seeding-limit\": 30,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"idle-seeding-limit-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"incomplete-dir\": \"/home/$USER/Downloads/Incomplete\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"incomplete-dir-enabled\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"lpd-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"max-peers-global\": 200,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"message-level\": 2,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-congestion-algorithm\": \"\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-id-ttl-hours\": 6,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-limit-global\": 200,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-limit-per-torrent\": 50,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-port\": 51413,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-port-random-high\": 65535,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-port-random-low\": 49152,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-port-random-on-start\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"peer-socket-tos\": \"default\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"pex-enabled\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"port-forwarding-enabled\": false, ">>/etc/transmission-daemon/settings.json.bak.bak   
    sudo echo "\"preallocation\": 1,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"prefetch-enabled\": 1,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"queue-stalled-enabled\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"queue-stalled-minutes\": 30,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"ratio-limit\": 2,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"ratio-limit-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rename-partial-files\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-authentication-required\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-bind-address\": \"0.0.0.0\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-enabled\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-password\": \"$xpassword\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-port\": 9091,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-url\": \"/transmission/\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-username\": \"$xusername\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-whitelist\": \"127.0.0.1\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"rpc-whitelist-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"scrape-paused-torrents-enabled\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"script-torrent-done-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"script-torrent-done-filename\": \"\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"seed-queue-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"seed-queue-size\": 10,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"speed-limit-down\": 100,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"speed-limit-down-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"speed-limit-up\": 100,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"speed-limit-up-enabled\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"start-added-torrents\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"trash-original-torrent-files\": false,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"umask\": 18,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"upload-limit\": 100,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"upload-limit-enabled\": 0,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"upload-slots-per-torrent\": 14,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"utp-enabled\": true,">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"watch-dir\": \"/home/$USER/Downloads/Torrents\",">>/etc/transmission-daemon/settings.json.bak.bak
    sudo echo "\"watch-dir-enabled\": true">>/etc/transmission-daemon/settings.json.bak.bak
sudo echo "}">>/etc/transmission-daemon/settings.json.bak.bak
sudo mv /etc/transmission-daemon/settings.json.bak.bak /etc/transmission-daemon/settings.json
sudo chmod 644 /etc/transmission-daemon/settings.json
sudo chmod 644 /etc/transmission-daemon/settings.json.bak
sudo /etc/init.d/transmission-daemon start
echo "Transmission installed."
}

xALL()
{
xSSH2
xUSB2
xSamba2
xTemp2
xWebmin2
xPlex2
xTrans2
echo "Installation complete!"
exit
}

xALL2()
{
xUpd2
xSSH2
xUSB2
xSamba2
xTemp2
xWebmin2
xPlex2
xTrans2
echo "Installation complete!"
exit
}

xControl()
{
while [ 1 ]
do 
	read choice
	case "$choice" in
	"1")
				xUpd
				;;
	"2")
                xSSH
                ;;
	"3")
                xUSB
                ;;
	"4")
                xSamba
                ;;
	"5")
                xTemp
                ;;
	"6")
                xWebmin
                ;;
	"7")
                xPlex
                ;;
	"8")
                xTrans
                ;;
	"9")
                xALL
                ;;
	"10")
				xALL2
				;;
	"11")
                exit
                ;;
	"12")
		xUpdate
		;;
	esac
done
}

xChoice()
{
echo ""
echo "Did you want to return to the install menu and install something else? (y/n)"
echo -n ":"
while [ 1 ]
do
	read choice
	case "$choice" in
	"y")
	    xReturn
	    ;;
	"n")
	    exit
	    ;;
	esac
done
}

xPrompt


exit $?
