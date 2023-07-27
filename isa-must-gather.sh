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
0. Exit
- - - - - - - - - - - - - -
 Choose the target component : ( 0 ~ 4 ) " OPTION_REPLY

read -p "Please Input MAS Instance ID: " INSTANCE_ID
read -p "Include Openshift Cluster logs (Y/N)? " INCLUDE_OPC
INCLUDE_OPC=${INCLUDE_OPC^^}

# need to validate inputs....
# how?
# return chosen option
case $OPTION_REPLY in
    "1")
        echo "[1. Entire MAS] was chosen"
				$FILE_PREFIX = "masmg"
        $MAS_COMPONENT_FLAG = "--mas-instance-id $INSTANCE_ID"
				;;
    "2")
        echo "[2. MAS Core] was chosen"
        $FILE_PREFIX = "coremg"
        $MAS_COMPONENT_FLAG = "-n mas-$INSTANCE_ID-core"
				;;
    "3")
        echo "[3. MAS Manage] was chosen"
				$FILE_PREFIX = "managemg"
        $MAS_COMPONENT_FLAG =  "-n mas-$INSTANCE_ID-manage"
        ;;
    "4")
        echo "[4. MAS Health] was chosen"
        $FILE_PREFIX = "healthmg"
        $MAS_COMPONENT_FLAG = "-n mas-$INSTANCE_ID-health"
				;;
    "0")
        echo "[0. Exit] was chosen"
				exit 0
        ;;

   *)
        "Invalid Option : cli exit..."
				exit 1
        ;;
esac


case $INCLUDE_OPCin
		"Y" | "YES")
				echo "INCLUDE Openshift logs"
				OCP_FLAG= "--image-stream=openshift/must-gather"
				;;
		"N" | "NO")
				echo "EXCLUDE Openshift logs"
				OCP_FLAG= " "
				;;
		*)
				echo "Unknown command."
        ;;
esac


# run command
echo "oc adm must-gather --dest-dir=./$FILE_PREFIX$(date "+%Y%m%d") $OCP_FLAG--image=quay.io/aiasupport/must-gather -- gather -cgl $MAS_COMPONENT_FLAG"
#oc adm must-gather --dest-dir=./$FILE_PREFIX$(date "+%Y%m%d") $OCP_FLAG--image=quay.io/aiasupport/must-gather -- gather -cgl $MAS_COMPONENT_FLAG



# if openshift cluster info is required
#--image-stream=openshift/must-gather

