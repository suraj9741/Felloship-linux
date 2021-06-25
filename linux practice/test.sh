#!/bin/bash

MODULE=$1
STAGE=$2
Folder_Map=`cat /etc/default/some.config | grep  -A 2 "#${MODULE}-${STAGE}" | grep "FOLDER_MAP"`
Users=`cat /etc/default/some.config | grep  -A 2 "#${MODULE}-${STAGE}" | grep "users"`

#echo "$Folder_Map"
#echo "$Users"
for i in $Users
do
 if [ "$i" = "$USER" ]; then
    f=1
    break
 else
    f=0
 fi
done

if [ "$f" = "1" ]; then
    for i in $Folder_Map
    do
      map=$i
      src=`echo $map | awk -F':' '{ print $1 }'`
      dest=`echo $map | awk -F':' '{ print $2 }'`
      sudo cp $src $dest
    done
else
    echo "User Is not authorize."
fi