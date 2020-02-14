#!/usr/bin/env bash
set -ex
# VARIABLE DECLARATION
DEFAULT=22
PORT=$DEFAULT
DEPLOY="./deploy"
REMOTE_DIR_DEFAULT=/tmp
REMOTE_DIR=$REMOTE_DIR_DEFAULT
SETUP="$REMOTE_DIR/deploy/setup.sh"
SCRIPTS_DEFAULT="$REMOTE_DIR/deploy/scripts"
SCRIPTS=$SCRIPTS_DEFAULT
#
#
# FIND INVENTORY, IF EXIST OR NOT
INVENTORY=`find ./inventory -type f -name "inventory"`
if [[ ! -f "$INVENTORY" ]];
 then
   # IF NOT FOUND, GIVE A ERROR MESSAGE
   echo "Inventory List does not exist"
   exit 1
fi

if [ ! -s "$INVENTORY" ]
then
  # IF EMPTY, GIVE A ERROR MESSAGE
	echo "$INVENTORY is empty. No inventory Records found!"
	exit 1
fi

# READ FROM INVENTORY - SERVER LIST
while IFS=  read  -r LINE; do
# READING EACH LINE
echo $LINE
SERVER=`echo "$LINE" | cut -f1 -d":"`
USERNAME=`echo "$LINE" | cut -f2 -d":"`
PASSWORD=`echo "$LINE" | cut -f3 -d":"`

#=COPY DEPLOYMENT SCRIPTS TO REMOTE SERVER=#
sshpass -p "$PASSWORD" -v scp -P $PORT -o "StrictHostKeyChecking no"  -r "$DEPLOY"  "$USERNAME"@"$SERVER":$REMOTE_DIR  </dev/null

#=SCRIPTS RUN ON REMOTE SERVER=#

sshpass -p "$PASSWORD" -v ssh  -p $PORT -o "StrictHostKeyChecking no"  "$USERNAME"@"$SERVER"  "sh $SETUP"  </dev/null
#= SCRIPTS RUN END=#

done < $INVENTORY
