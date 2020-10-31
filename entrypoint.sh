#! /bin/sh

echo Booting World $WORLD
curl `curl https://www.minecraft.net/en-us/download/server | grep -o https.*server.jar` -o /server.jar
mkdir -p /mnt/worlds/$WORLD/generated/minecraft/structures
ln -s /mnt/worlds/global /mnt/worlds/$WORLD/generated/minecraft/structures/ || true
/usr/bin/java -Xmx6G -jar /server.jar --nogui --universe /mnt/worlds --world $WORLD
