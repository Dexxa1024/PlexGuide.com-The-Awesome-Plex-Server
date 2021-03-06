 #!/bin/bash

clear

function contextSwitch {
    {
    ctxt1=$(grep ctxt /proc/stat | awk '{print $2}')
        echo 50
    sleep 1
        ctxt2=$(grep ctxt /proc/stat | awk '{print $2}')
        ctxt=$(($ctxt2 - $ctxt1))
        result="Number os context switches in the last secound: $ctxt"
    echo $result > result
    } | whiptail --gauge "Getting data ..." 6 60 0
}


function userKernelMode {
    {
    raw=( $(grep "cpu " /proc/stat) )
        userfirst=$((${raw[1]} + ${raw[2]}))
        kernelfirst=${raw[3]}
    echo 50
        sleep 1
    raw=( $(grep "cpu " /proc/stat) )
        user=$(( $((${raw[1]} + ${raw[2]})) - $userfirst ))
    echo 90
        kernel=$(( ${raw[3]} - $kernelfirst ))
        sum=$(($kernel + $user))
        result="Percentage of last sekund in usermode: \
        $((( $user*100)/$sum ))% \
        \nand in kernelmode: $((($kernel*100)/$sum ))%"
    echo $result > result
    echo 100
    } | whiptail --gauge "Getting data ..." 6 60 0
}

function interupts {
    {
    ints=$(vmstat 1 2 | tail -1 | awk '{print $11}')
        result="Number of interupts in the last secound:  $ints"
    echo 100
    echo $result > result
    } | whiptail --gauge "Getting data ..." 6 60 50
}

while [ 1 ]
do
CHOICE=$(
whiptail --title "Install Menu" --menu "Make your choice" 19 32 12 \
    "1)" "Plex"   \
    "2)" "Emby"  \
    "3)" "Muximux"  \
    "4)" "Netdata"  \
    "5)" "NZBGET"  \
    "6)" "NZBHydra"  \
    "7)" "OMBIv3"  \
    "8)" "Organizr"  \
    "9)" "Radarr"  \
    "10)" "Resilio"  \
    "11)" "SABNZBD"  \
    "12)" "Sonarr"  \
    "13)" "Tautulli"  \
    "14)" "Test"  \
    "0)" "Plex Claim Test"  \
    "15)" "Exit  "  3>&2 2>&1 1>&3
)

result=$(whoami)
case $CHOICE in
    "1)")
     clear
     bash /opt/plexguide/scripts/menus/plexsub-menu.sh
     ;;

    "2)")
    ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags emby
    echo "Emby: http://ipv4:8096 | For NGINX Proxy emby.domain.com"
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
      ;;

    "3)")
    ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags muximux
    echo "Muximux: http://ipv4:8015 | For NGINX Proxy muximux.domain.com"
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
     ;;

    "4)")
    ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags netdata
    echo "NetData: http://ipv4:19999 | For NGINX Proxy netdata.domain.com"
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
     ;;

    "5)")
    ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags nzbget
    echo "NZBGET: http://ipv4:6789 | For NGINX Proxy nzbget.domain.com"
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
     ;;

    "6)")
    ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags nzbhydra
    echo "NZBHydra: http://ipv4:5075 | For NGINX Proxy nzbhyra.domain.com"
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
     ;;

    "7)")
    ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags ombi
    echo "Ombi: http://ipv4:3579 | For NGINX Proxy ombi.domain.com"
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
     ;;

    "8)")
    ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags organizr
    echo "Organizr: http://ipv4:8020 | For NGINX Proxy organizr.domain.com"
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
     ;;

    "9)")
    ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags radarr
    echo "Radarr: http://ipv4:7878 | For NGINX Proxy radarr.domain.com"
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
     ;;

    "10)")
    ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags resilio
    echo "Resilio: http://ipv4:8888 | For NGINX Proxy resilio.domain.com"
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
    ;;

    "11)")
    ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags sabnzbd
    echo "SABNZBD: http://ipv4:8090 | For NGINX Proxy sabnzbd.domain.com"
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
    ;;

    "12)")
    ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags sonarr
    echo "Sonarr: http://ipv4:8989 | For NGINX Proxy sonarr.domain.com"
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
    ;;

    "13)")
    ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags tautulli
    echo "Tautulli: http://ipv4:8181 | For NGINX Proxy tautulli.domain.com"
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
    ;;

    "14)")
    ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags nginx-proxy
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
    ;;

    "0)")
    ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags plex-claim
    echo ""
    read -n 1 -s -r -p "Press any key to continue "
    ;;
    
     "15)")
      clear
      exit 0
      ;;
esac
done
exit
