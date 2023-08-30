#!/bin/bash

cat << "EOF"
    _                                       __                    __  __             
   (_)________ _      ____ ___  __  _______/ /_      ____ _____ _/ /_/ /_  ___  _____
  / / ___/ __ `/_____/ __ `__ \/ / / / ___/ __/_____/ __ `/ __ `/ __/ __ \/ _ \/ ___/
 / (__  ) /_/ /_____/ / / / / / /_/ (__  ) /_/_____/ /_/ / /_/ / /_/ / / /  __/ /    
/_/____/\__,_/     /_/ /_/ /_/\__,_/____/\__/      \__, /\__,_/\__/_/ /_/\___/_/     
                                                  /____/                             
EOF

# print about
echo "Welcome to ISA-MUST-GATHER!
It is a friendly cli tool that allows users to easily run ibm's must gather tool. 
Trust me you will need it.
by Isaac Lee"


# choose mustgather options
while true; do
    read -p "
    - - - - - - - - - - - - - -
    MAS COMPONENTS:

    1. MAS application
    2. MAS Core
    3. MAS Manage
    4. MAS Health
    5. Suite Licensing Service (SLS)
    6. Mongo DB
    0. Exit
    - - - - - - - - - - - - - -
    Which MAS component log do you need? ( 1 ~ 5 ) [Default: 1]:  " OPTION_REPLY

    # Set default value if empty
    OPTION_REPLY=${OPTION_REPLY:-1}

    # Check if the value is between 1 to 5
    if [[ "$OPTION_REPLY" =~ ^[1-6]$ ]]; then
        break
    else
        echo "Invalid input. Please choose a number from 0 to 6."
    fi
done

read -p "Please Input MAS Instance ID [Default: inst]: " INSTANCE_ID
INSTANCE_ID=${INSTANCE_ID:-inst}

while true; do
    read -p "Include Openshift Cluster logs (Y/N) [Default: N]? " INCLUDE_OCP

    # Convert to uppercase and set default value if empty
    INCLUDE_OCP=$(echo ${INCLUDE_OCP:-N} | tr '[:lower:]' '[:upper:]')

    # Check if the value is Y or N
    if [[ "$INCLUDE_OCP" == "Y" || "$INCLUDE_OCP" == "N" ]]; then
        break
    else
        echo "Invalid input. Please enter 'Y' or 'N'."
    fi
done

# return chosen option
case $OPTION_REPLY in
    "1")
        OPTION_NAME="MAS application"
		FILE_PREFIX="masmg"
        MAS_COMPONENT_FLAG="--mas-instance-id $INSTANCE_ID"
		;;
    "2")
        OPTION_NAME="MAS Core"   
        FILE_PREFIX="coremg"
        MAS_COMPONENT_FLAG="-n mas-$INSTANCE_ID-core"
		;;
    "3")
        OPTION_NAME="MAS Manage"
		FILE_PREFIX="managemg"
        MAS_COMPONENT_FLAG="-n mas-$INSTANCE_ID-manage"
        ;;
    "4")
        OPTION_NAME="MAS Health"
        FILE_PREFIX="healthmg"
        MAS_COMPONENT_FLAG="-n mas-$INSTANCE_ID-health"
		;;
    "5")
        OPTION_NAME="Suite Licensing Service (SLS)"
        FILE_PREFIX="sls"
        MAS_COMPONENT_FLAG="-n ibm-sls"
		;;
    "6")
        OPTION_NAME="Mongo DB"
        FILE_PREFIX="mongodb"
        MAS_COMPONENT_FLAG="-n mongo"
        ;;

    "0")
        echo "[0. Exit] was chosen"
		exit 0
        ;;

   *)
        echo "Invalid Option : cli exit..."
		exit 1
        ;;
esac


case $INCLUDE_OCP in
		"Y" | "YES")
				echo "INCLUDE Openshift logs"
				OCP_FLAG="--image-stream=openshift/must-gather "
				;;
		"N" | "NO")
				echo "EXCLUDE Openshift logs" 
				OCP_FLAG=" "
				;;
		*)      
				echo "[error] OCP_OPTION : input error. Default = 'N'"
                OCP_FLAG=" "
        ;;
esac

# Store the current date and time in a variable for consistency
CURRENT_DATETIME=$(date "+%Y%m%d_%H%M%S")

# run command
echo "oc adm must-gather --dest-dir=./$FILE_PREFIX$CURRENT_DATETIME $OCP_FLAG--image=quay.io/aiasupport/must-gather -- gather -cgl $MAS_COMPONENT_FLAG"
oc adm must-gather --dest-dir=./$FILE_PREFIX$CURRENT_DATETIME $OCP_FLAG--image=quay.io/aiasupport/must-gather -- gather -cgl $MAS_COMPONENT_FLAG
echo "✔️ must-gather completed"
#make into tar.ball
tar -czvf "$FILE_PREFIX$CURRENT_DATETIME".tar.gz ./$FILE_PREFIX$CURRENT_DATETIME/
echo "✔️ tarball completed"

# Delete the folder after creating the tarball
rm -rf ./"$FILE_PREFIX$CURRENT_DATETIME"/
echo "✔️ directory removed"