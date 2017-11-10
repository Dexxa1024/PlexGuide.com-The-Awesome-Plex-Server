####### Agree to Install Plex Server

clear
echo -n "Do you Agree to utilize the PlexGuide Program (y/n)? "
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^y" ;then
    echo Yes;
    yes | apt-get update
    yes | apt-get install nano
    yes | apt-get install fuse
    yes | apt-get install man-db
    yes | apt-get install screen
    yes | apt-get install unzip
## yes | apt-get install fail2ban ## install disabled until configured properly
## yes | apt-get install ufw ## install disabled until configured properly
    yes | apt-get install python
    yes | apt-get install software-properties-common
    mkdir /var/plexguide 
    touch /var/plexguide/dep.yes
    clear
    echo "Installed Required Dependicies"
    echo
else
    echo No
    clear
    echo "Install Aborted - You Failed to Agree to Install"
    echo
    exit
fi