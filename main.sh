#!/usr/bin/env bash
set -ex
DEFAULT=22
PORT=$DEFAULT
SCRIPTS=$1
COUNTER=1
DEPLOY="./deploy"
REMOTE_DIR=/tmp/
SETUP="/tmp/deploy/setup.sh"
#
#https://devdojo.com/tutorials/executing-bash-script-on-multiple-remote-server
#Find inventory exists or Not

INVENTORY=`find ./inventory -type f -name "inventory"`
if [[ ! -f "$INVENTORY" ]];
 then
   echo "Inventory List  does not exist"
   exit 1
fi

if [ ! -s "$INVENTORY" ]
then
	echo "$INVENTORY is empty. No inventory Records found!"
        # do something as file is empty
fi

#Read From Inventroy - Server List
while read  -r LINE; do
# reading each line
[[ "$LINE" =~ ^[[:space:]]*# ]] && continue
echo $LINE
SERVER=`echo "$LINE" | cut -f1 -d":"`
USERNAME=`echo "$LINE" | cut -f2 -d":"`
PASSWORD=`echo "$LINE" | cut -f3 -d":"`
#================SCP============================================================================================#
sshpass -p "$PASSWORD" -v scp -o "StrictHostKeyChecking no"  -r "$DEPLOY"  "$USERNAME"@"$SERVER":$REMOTE_DIR  </dev/null

#=============DIRECT SCRIPTS RUN ON REMOTE SERVER===============================================================#

sshpass -p "$PASSWORD" -v ssh -o "StrictHostKeyChecking no"  "$USERNAME"@"$SERVER"  "sh $SETUP"  </dev/null
#=============DIRECT SCRIPTS RUN END============================================================================#

COUNTER=$[$COUNTER +1]
done < $INVENTORY
echo $[$COUNTER -1]
