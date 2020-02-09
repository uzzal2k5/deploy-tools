#!/usr/bin/env bash
set -ex
SCRIPTS=$1
COUNTER=1
 #
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

#cat ${SCRIPTS} | sshpass -p "$PASSWORD" -v ssh -o "StrictHostKeyChecking no"  "$USERNAME"@"$SERVER" </dev/null
#sshpass -p "$PASSWORD" -v ssh -o "StrictHostKeyChecking no"  "$USERNAME"@"$SERVER" 'ls -la' </dev/null
cat ${SCRIPTS} | sshpass -p "$PASSWORD" -v ssh -o "StrictHostKeyChecking no"  "$USERNAME"@"$SERVER"
COUNTER=$[$COUNTER +1]
done < $INVENTORY
echo $COUNTER

