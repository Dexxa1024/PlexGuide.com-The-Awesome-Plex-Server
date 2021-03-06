
 #!/bin/bash

#check to see if /var/plexguide/dep exists - if not, install dependencies
clear

whiptail --title "Plex Information" --msgbox "If installing Plex on your OWN LOCAL Network, visit http//ip:32400/web to complete the install. If installing Plex on a REMOTE SERVER have your Plex Claim Token ready by heading over to https://plex.tv/claim , and remember that the claim token is valid only for 4 minutes at a time! If, for some reason, the claim process should not work, head over to http://wiki.plexguide.com and use a manual method!" 18 78

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
whiptail --title "Plex Version Select" --menu "Make your choice" 10 28 3 \
    "1)" "Plex Stable"   \
    "2)" "Plex Beta"  \
    "3)" "Exit  "  3>&2 2>&1 1>&3
)

result=$(whoami)
case $CHOICE in
    "1)")
    ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags plex
    echo ""
    read -n 1 -s -r -p "Press any key to continue"
    whiptail --title "Installed Plex Public" --msgbox "The Stable Version Of Plex Has Been Installed! Read The Wiki!" 9 50

    ;;

    "2)")
    ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags plex-beta
        echo ""
    read -n 1 -s -r -p "Press any key to continue"
    whiptail --title "Installing Plex Beta" --msgbox "The Beta Version Of Plex Has Been Installed! Read The Wiki!" 9 50
    ;;

    "3)")
        clear
        exit 0
        ;;
esac
done
exit
