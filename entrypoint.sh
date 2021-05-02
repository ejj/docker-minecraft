#!/bin/bash

echo "Booting World ($WORLD)"

URL="https://www.minecraft.net/en-us/download/server"
if [[ "$WORLD" == *-snap ]]
then
    URL="https://www.minecraft.net/en-us/article/minecraft-snapshot-21w17a"
fi

echo $URL
curl `curl $URL | grep -o https.*/server.jar` -o /server.jar
mkdir -p /mnt/worlds/$WORLD/generated/minecraft/structures
ln -s /mnt/worlds/global /mnt/worlds/$WORLD/generated/minecraft/structures/ || true
/usr/bin/java -Xmx6G -jar /server.jar --nogui --universe /mnt/worlds --world $WORLD
