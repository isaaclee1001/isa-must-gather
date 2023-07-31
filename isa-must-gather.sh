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
read -p "
- - - - - - - - - - - - - -
MAS COMPONENTS:

1. MAS application
2. MAS Core
3. MAS Manage
4. MAS Health
5. Exit
- - - - - - - - - - - - - -
Which MAS component log do you need? ( 1 ~ 5 ):  " OPTION_REPLY

read -p "Please Input MAS Instance ID: " INSTANCE_ID
read -p "Include Openshift Cluster logs (Y/N)? " INCLUDE_OCP
#INCLUDE_OPC_UPPERCASE="${INCLUDE_OPC^^}"
#echo ${INCLUDE_OPC}
# need to validate inputs....
# how?
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
        echo "[5. Exit] was chosen"
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


# run command
echo "oc adm must-gather --dest-dir=./$FILE_PREFIX$(date "+%Y%m%d") $OCP_FLAG--image=quay.io/aiasupport/must-gather -- gather -cgl $MAS_COMPONENT_FLAG"
oc adm must-gather --dest-dir=./$FILE_PREFIX$(date "+%Y%m%d") $OCP_FLAG--image=quay.io/aiasupport/must-gather -- gather -cgl $MAS_COMPONENT_FLAG
echo "✔️ must-gather completed"
#make into tar.ball
tar -czvf "$FILE_PREFIX$(date "+%Y%m%d")".tar.gz ./$FILE_PREFIX$(date "+%Y%m%d")/
echo "✔️ tarball completed "
